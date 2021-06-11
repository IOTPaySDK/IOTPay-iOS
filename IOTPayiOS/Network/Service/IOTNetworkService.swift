//
//  OneTimePurchaseService.swift.swift
//
//
//  Created by macbook on 2021-04-15.
//

import Foundation

@objc
public protocol IOTNetworkServiceDelegate: AnyObject {
	@objc
	func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String)

	@objc
	func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String)
}


public class IOTNetworkService: NSObject {

	private let logNetworkData = true

	private var _secureId: String?
	private var secureId: String { return checkSecureId() }
	private var route: IOTIOTHTTPNetworkRoute?
	private weak var viewComponents: IOTCardInfoComponents?
	private weak var timer: Timer?
	private var timerCounter: Int = 0
	private var isCheckingPurchaseResultLooping = false

	@objc
	public static let shared = IOTNetworkService()

	@objc
	public weak var delegate: IOTNetworkServiceDelegate?

	private override init() { }

	private func startTimer() {
		stopTimer()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (t) in
			if t.isValid {
				self?.viewComponents?.transport()
			}
		})
	}

	private func stopTimer() {
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
		timerCounter = 0
	}

	deinit { stopTimer() }

	@objc
	public func sendRequest(secureId: String, cardInfoView: IOTCardInfoView) {
		_secureId = secureId
		route = IOTIOTHTTPNetworkRoute(action: cardInfoView.action)
		viewComponents = cardInfoView.facade.viewComponents
		viewComponents?.transportDelegate = self
		viewComponents?.transport()
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




	func paymentFail(msg: String?) {
		print("payment fail, retMsg: ", msg ?? "no msg")
	}

	func startNetworkRequest(route: IOTIOTHTTPNetworkRoute,
													 data: Data,
													 onComplete: @escaping (Data) -> ()) {
//		#if DEBUG
//		print("Start Network Request --This Log only appear in Debug mode-- \n",
//					"Route: ", route, "\n",
//					"Request Data: ", String(data: data, encoding: .utf8)!)
//		#endif

		guard let request = makeRequest(route: self.route!, data: data) else { return }

		#if DEBUG
		if logNetworkData { printRequestData(url: request.url, data: data) }
		#endif

		let postSession = URLSession(configuration: .default)
		let task = postSession.dataTask(with: request) { [weak self] (data, response, error) in

			if let logNetworkData = self?.logNetworkData, logNetworkData {
				self?.printResponseData(data: data, response: response, error: error)
			}

//			#if DEBUG
//				guard let str = request else { return }
//				//print(String(data: data, encoding: .utf8)!)
//			#endif

			do {
				//MARK: error
				if error != nil {
					//TODO, error handling
//					guard let error = error else {
//						throw IOTHTTPNetworkError.failedCauseReceiveErrorAtURLSessionAndFailedToLogError
//					}
					print("Failed Cause Receive Error At URLSession errorMsg: ", error ?? "Error EMPTY")
					return
				}

				//MARK: response
				guard let response = response as? HTTPURLResponse else {
					print("Filed to get response from server")
					return
				}

				guard (200...299).contains(response.statusCode) else {
					print("Filed due to response problem with response.statsCode:", response.statusCode)
					return
				}

				//MARK: data
				guard let data = data else { throw IOTHTTPNetworkError.taskNotReceiveingData }

				if let baseResponse = try? JSONDecoder().decode(IOTBaseResponseData.self, from: data) {
					switch baseResponse.retCode {
						case .SUCCESS:
//							guard let retData = baseResult.retData else {
//								throw IOTHTTPNetworkError.failedToDecodingAddCardResponseData
//							}
							onComplete(data)
						case .FAIL:
							self?.paymentFail(msg: baseResponse.retMsg)
//							guard let retMsg = result.retMsg else {
//								throw IOTHTTPNetworkError.failedToDecodingAddCardResponseDataAndFailedToFindMsg
//							}
					}

				} else {
					throw IOTHTTPNetworkError.failedToDecodingBaseResponseData
				}
//			}
			} catch let taskError {
				print(taskError)
			}
		}
		task.resume()
	}

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



	private func makeRequest(route: IOTIOTHTTPNetworkRoute, data: Data) -> URLRequest? {
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


extension IOTNetworkService: IOTCardInfoComponentsTransportDelegate {
	func transport(route: IOTIOTHTTPNetworkRoute, info: IOTCardInfo) {

		let requested = IOTRequestCardData(secureId: secureId, cardInfo: info)
		guard let jsonData = try? JSONSerialization.data(withJSONObject: requested.params) else {
			print("JSONSerialization network request data error")
			return
		}

		startNetworkRequest(route: route, data: jsonData) { [weak self] (jsonData: Data) in
			print("in start net work request call back")
//			let retData = baseResponse.retCode

			switch route {
			case .addCard:
				guard let res = try? JSONDecoder().decode(IOTAddCardResponseData.self, from: jsonData)
				else {
					print("decode retData to IOTAddCardResponseData failed")
					return
					//throw IOTHTTPNetworkError.failedToDecodingAddCardResponseData
				}
				let desensitizedCardInfo = res.retData.desensitizedCardInfo
				self?.delegate?.onDidAddCard(desensitizedCardInfo: desensitizedCardInfo,
																		 redirectUrl: res.retData.redirectUrl)

			case .oneTimePurchase, .retryPurchase:
				guard let res = try? JSONDecoder().decode(IOTPurchaseResponseData.self, from: jsonData)
				else { return }
				let retData = res.retData
				if retData.status == 2 || retData.status == 3 {
					self?.delegate?.onDidPurchase(purchaseReceipt: retData.purchaseReceipt,
																				redirectUrl: retData.redirectUrl)
					self?.isCheckingPurchaseResultLooping = false
				} else if retData.status == 9 && route == .retryPurchase {
					self?.paymentFail(msg: res.retMsg)
					self?.isCheckingPurchaseResultLooping = false
					//self?.stopTimer()
				} else {
					self?.isCheckingPurchaseResultLooping = true
					self?.route = .retryPurchase
					self?.timerCounter += 1

					DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
						if let timerCounter = self?.timerCounter, let boolVal = self?.isCheckingPurchaseResultLooping {
							if timerCounter <= 30 && boolVal {
								self?.viewComponents?.transport()
							}
						}
					}
				}
			}
		}
	}
}


