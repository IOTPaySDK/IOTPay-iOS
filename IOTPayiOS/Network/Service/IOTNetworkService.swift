//
//  OneTimePurchaseService.swift.swift
//
//
//  Created by macbook on 2021-04-15.
//

import Foundation

@objc
public protocol IOTNetworkAddCardDelegate: AnyObject {
	@objc
	func onDidAddCardSuccess(msg: String, desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String)

	@objc
	func onDidAddCardFail(msg: String)
}

@objc
public protocol IOTNetworkPurchaseDelegate: AnyObject {
	@objc
	func onDidPurchaseSuccess(msg: String, purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String)

	@objc
	func onDidPurchaseFail(msg: String)

	@objc
	func onDidPurchaseUnknow(msg: String)
}


public class IOTNetworkService: NSObject {

	// for DEV, should be false for release
	#if DEBUG
	@objc
	public var logNetworkData = true
	#else
	private let logNetworkData = false
	#endif

	@objc
	public static let shared = IOTNetworkService()
	//@objc
	//public weak var delegate: IOTNetworkServiceDelegate?
	@objc
	public weak var addCardDelegate: IOTNetworkAddCardDelegate?
	@objc
	public weak var purchaseDelegate: IOTNetworkPurchaseDelegate?

	private weak var viewComponents: IOTCardInfoComponents?
	private var _secureId: String?
	private var secureId: String { return checkSecureId() }
	private var curRoute: IOTHTTPNetworkRoute?

	//private weak var timer: Timer?
	private var timerCounter: Int = 0
	private var isCheckingPurchaseResultLooping = false

	private override init() { } //singleton

	@objc
	public func sendRequest(secureId: String, cardInfoView: IOTCardInfoView) {
		_secureId = secureId
		curRoute = IOTHTTPNetworkRoute(action: cardInfoView.action)
		isCheckingPurchaseResultLooping = false
		timerCounter = 0
		viewComponents = cardInfoView.facade.viewComponents
		viewComponents?.transportDelegate = self
		viewComponents?.transport()
	}

//	func paymentFail(msg: String?) {
//		print("payment fail, retMsg: ", msg ?? "no msg")
//	}

	func requestFail(errorMsg: String?) {
		switch curRoute {
			case .addCard:
				addCardDelegate?.onDidAddCardFail(msg: errorMsg ?? "errorMsg Empty")
			case .oneTimePurchase, .retryPurchase:
				purchaseDelegate?.onDidPurchaseFail(msg: errorMsg ?? "errorMsg Empty")
			case .none: break
		}
	}

	func startNetworkRequest(route: IOTHTTPNetworkRoute,
													 data: Data,
													 onComplete: @escaping (Data) -> ()) {

		guard let request = makeRequest(route: curRoute!, data: data) else { return }

		#if DEBUG
		if logNetworkData { printRequestData(url: request.url, data: data) }
		#endif

		let postSession = URLSession(configuration: .default)
		let task = postSession.dataTask(with: request) { [weak self] (data, response, error) in

			if let logNetworkData = self?.logNetworkData, logNetworkData {
				self?.printResponseData(data: data, response: response, error: error)
			}

			do {
				//MARK: error
				if error != nil {
					//TODO, error handling
//					guard let error = error else {
//						throw IOTHTTPNetworkError.failedCauseReceiveErrorAtURLSessionAndFailedToLogError
//					}
					//print("Failed Cause Receive Error At URLSession errorMsg: ", error ?? "Error EMPTY")
					self?.requestFail(errorMsg: "Received Error: \(error?.localizedDescription ?? "error Empty")")
					return
				}

				//MARK: response
				guard let response = response as? HTTPURLResponse else {
					//print("Filed to get response from server")
					self?.requestFail(errorMsg: "Response nil: \(error?.localizedDescription ?? "response Empty")")
					return
				}

				guard (200...299).contains(response.statusCode) else {
					//print("response.statsCode: ", response.statusCode)
					self?.requestFail(errorMsg: "Response Error code: \(response.statusCode), error: \(error?.localizedDescription ?? "error Empty")")
					return
				}

				//MARK: data
				guard let data = data else {
					self?.requestFail(errorMsg: "Data nil: \(response.statusCode), error: \(error?.localizedDescription ?? "error Empty")")
					throw IOTHTTPNetworkError.taskNotReceiveingData
				}

				if let baseResponse = try? JSONDecoder().decode(IOTBaseResponseData.self, from: data) {
					switch baseResponse.retCode {
						case .SUCCESS: onComplete(data)
						case .FAIL:
							self?.requestFail(errorMsg: "Data Error: \(baseResponse.retMsg ?? "retMsg Empty"), \(error?.localizedDescription ?? "error Empty")")
					}
				} else {
					self?.requestFail(errorMsg: "Data Error: decode data failed")
					throw IOTHTTPNetworkError.failedToDecodingBaseResponseData
				}
			} catch let taskError {
				print(taskError)
			}
		}
		task.resume()
	}

	private func makeRequest(route: IOTHTTPNetworkRoute, data: Data) -> URLRequest? {
		do {
			guard let request = try? IOTHTTPNetworkRequest.configureHTTPRequest(from: route,
																																			 with: [:],
																																			 includes: [:],
																																			 contains: data,
																																			 and: .post) else {
				throw IOTHTTPNetworkError.taskErrorStopBeforeSendingRequest
			}
			return request
		} catch let requestError {
			print(requestError)
			return nil
		}
	}
}

//Handling result
extension IOTNetworkService {
	private func responseHandler(route: IOTHTTPNetworkRoute, responseData: Data) {
		switch route {
		case .addCard:
			guard let res = try? JSONDecoder().decode(IOTAddCardResponseData.self, from: responseData)
			else {
				//print("decode retData to IOTAddCardResponseData failed")
				requestFail(errorMsg: "Decode Error: decode retData to IOTAddCardResponseData failed")
				return
				//throw IOTHTTPNetworkError.failedToDecodingAddCardResponseData
			}
			if !res.retCode.isSuccess {
				addCardDelegate?.onDidAddCardFail(msg: res.retMsg ?? "")
			} else {
				addCardDelegate?.onDidAddCardSuccess(msg: res.retMsg ?? "",
																						 desensitizedCardInfo: res.retData.desensitizedCardInfo,
																						 redirectUrl: res.retData.redirectUrl)
			}

		case .oneTimePurchase, .retryPurchase:

			guard let res = try? JSONDecoder().decode(IOTPurchaseResponseData.self, from: responseData)
			else {
				requestFail(errorMsg: "Decode Error: decode retData to IOTPurchaseResponseData failed")
				return
			}

			if !res.retCode.isSuccess || (res.retCode.isSuccess && res.retData.status == 9){
				isCheckingPurchaseResultLooping = false
				//purchaseDelegate?.onDidPurchaseFail(msg: res.retMsg ?? "")
				requestFail(errorMsg: res.retMsg ?? "retMsg Empty")
			} else if res.retCode.isSuccess && (res.retData.status == 2 || res.retData.status == 3) {
				isCheckingPurchaseResultLooping = false
				purchaseDelegate?.onDidPurchaseSuccess(msg: res.retMsg ?? "",
																							 purchaseReceipt: res.retData.purchaseReceipt,
																							 redirectUrl: res.retData.redirectUrl)
			} else {
				isCheckingPurchaseResultLooping = true
				curRoute = .retryPurchase
				timerCounter += 1
				if timerCounter >= 30 {
					purchaseDelegate?.onDidPurchaseUnknow(msg: res.retMsg ?? "retMsg Empty")
				} else { //retry
					DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
						if self != nil, self!.isCheckingPurchaseResultLooping {
							self!.viewComponents?.transport()
						}
					}
				}
			}
		}
	}
}


extension IOTNetworkService: IOTCardInfoComponentsTransportDelegate {
	func transport(route: IOTHTTPNetworkRoute, info: IOTCardInfo) {

		let requested = IOTRequestCardData(secureId: secureId, cardInfo: info)
		guard let jsonData = try? JSONSerialization.data(withJSONObject: requested.params) else {
			requestFail(errorMsg: "Encode Error: encode data to IOTRequestCardData failed")
			return
		}

		startNetworkRequest(route: route, data: jsonData) { [weak self] (responseData: Data) in
			self?.responseHandler(route: route, responseData: responseData)
		}
	}
}

// DEV print
extension IOTNetworkService {
	private func printRequestData(url: URL?, data: Data) {
		#if DEBUG
		print("Start Network Request --This Log only appear in Debug mode-- \n",
					"Route: \(url!) \n",
					"Request Data: ", String(data: data, encoding: .utf8)!)
		#endif
	}

	private func printResponseData(data: Data?, response: URLResponse?, error: Error?) {
		#if DEBUG
		print("On Receive Network Response --This Log only appear in Debug mode-- \n",
					"Error: ", error ?? "Error EMPTY", "\n",
					"Resonse: ", response ?? "Response EMPTY", "\n")
		if data != nil {
			print("Data: ", String(data: data!, encoding: .utf8)!, "\n")
		} else {
			print("Data: ", "Data EMPTY", "\n")
		}
		print("unionPay checkLoopCount: ", timerCounter)
		#endif
	}

	private func checkSecureId() -> String! {
		#if DEBUG
			let defaultString = "your secureid"
			guard let _secureId = _secureId, _secureId.lowercased() != defaultString,
						_secureId.count >= 20 else {
				printSecureIdErrorMsg()
				fatalError("Error: secureId invalid")
			}
			return _secureId
		#else
			print("Error: secureId invalid")
			return secureId ?? ""
		#endif
	}

	private func printSecureIdErrorMsg() {
		#if DEBUG
			fatalError("""
							You secureId is invalid, please check Github guide, secureId section at end of
							https://github.com/IOTPaySDK/IOTPay-iOS
							This Fatal error only occurs in DEBUG mode, it will just return and with fail
							network status on real device
							""")
		#else
			return
		#endif
	}


}

// legacy use timer for retry
//extension IOTNetworkService {
//	private func startTimer() {
//		stopTimer()
//		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (t) in
//			if t.isValid {
//				self?.viewComponents?.transport()
//			}
//		})
//	}
//
//	private func stopTimer() {
//		if timer != nil {
//			timer?.invalidate()
//			timer = nil
//		}
//		timerCounter = 0
//	}
//
//	deinit { stopTimer() }
//}


