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

	@objc
	public static let shared = IOTNetworkService()

	@objc
	public weak var delegate: IOTNetworkServiceDelegate?

	var secureId: String = ""
	var loginName: String = ""

	private override init() { }

	@objc
	public func sendRequest(secureId: String, loginName: String, cardInfoView: IOTCardInfoView) {
		self.secureId = secureId
		self.loginName = loginName
		let viewComponents = cardInfoView.facade.viewComponents
		viewComponents.transportDelegate = self
		viewComponents.transport()
	}

	func addCard(data: Data, _ onComplete: @escaping (IOTAddCardRetData) -> ()) {
//		do {
//			guard let request = try? HTTPNetworkRequest.configureHTTPRequest(from: .addCard,
//																																			 with: [:],
//																																			 includes: [:],
//																																			 contains: data,
//																																			 and: .post) else {
//				throw HTTPNetworkError.taskErrorStopBeforeSendingRequest
//			}

//			(request.httpBody)

		guard let request = makeRequest(action: .addCard, data: data) else { return }

		let postSession = URLSession(configuration: .default)
		let task = postSession.dataTask(with: request) { (data, response, error) in
			do {
				//MARK: error
				if error != nil {
					//TODO, error handling
					guard let error = error else {
						throw HTTPNetworkError.failedCauseReceiveErrorAtURLSessionAndFailedToLogError
					}
					print("Failed Cause Receive Error At URLSession errorMsg: ", error)
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
				guard let data = data else { throw HTTPNetworkError.taskNotReceiveingData}


//							 do {
//									 let a = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//								print("fasdaaaa", a)
//							 } catch {
//									 print(error.localizedDescription)
//							 }

//				if let data = text.data(using: .utf8) {
//							do {
//									let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
//									//print("jsonnnn", json)
//							} catch {
//									print("Something went wrong")
//							}
//				}
//				if let result  = try? JSONSerialization.jsonObject(with: result, options: []) as? [String: Any] {
//					// try to read out a string array
//						print("aafinal get ", result)
//					}


				if let result = try? JSONDecoder().decode(IOTAddCardResponseData.self, from: data) {

					switch result.retCode {
						case .SUCCESS:
							guard let retData = result.retData else {
								throw HTTPNetworkError.failedToDecodingAddCardResponseData
							}
							onComplete(retData)
						case .FAIL:
							guard let retMsg = result.retMsg else {
								throw HTTPNetworkError.failedToDecodingAddCardResponseData
							}
							print("Failed retCode = .FAIL, Msg:", retMsg)
//							///remove start
//
//							if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String]{
//
//								let firstElement = json.first ?? "Element Not Found!"
//
//											print(firstElement)
//							}
//
//						//// remove end
					}

				} else {

					if let baseData = try? JSONDecoder().decode(IOTBaseResponseData.self, from: data) {
						guard let retMsg = baseData.retMsg else {
							throw HTTPNetworkError.failedToDecodingBaseResponseDataAndFailedToFindMsg
						}
						print("Failed decoding baseData with Msg:", baseData.retCode, retMsg)
					} else {
						throw HTTPNetworkError.failedToDecodingBaseResponseData
					}

				}
			} catch let taskError {
				print(taskError)
			}
		}
		task.resume()
	}

	func oneTimePurchase(data: Data, _ onComplete: @escaping (IOTPurchaseRetData) -> ()) {
		guard let request = makeRequest(action: .oneTimePurchase, data: data) else { return }

			let postSession = URLSession(configuration: .default)
			let task = postSession.dataTask(with: request) { (data, response, error) in
			do {
				//MARK: error
				if error != nil {
					//TODO, error handling
					guard let error = error else {
						throw HTTPNetworkError.failedCauseReceiveErrorAtURLSessionAndFailedToLogError
					}
					print("Failed Cause Receive Error At URLSession errorMsg: ", error)
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
				guard let data = data else { throw HTTPNetworkError.taskNotReceiveingData}

				if let result = try? JSONDecoder().decode(IOTPurchaseResponseData.self, from: data) {

					switch result.retCode {
						case .SUCCESS:
							guard let retData = result.retData else {
								throw HTTPNetworkError.failedToDecodingAddCardResponseData
							}
							onComplete(retData)
						case .FAIL:
							guard let retMsg = result.retMsg else {
								throw HTTPNetworkError.failedToDecodingAddCardResponseDataAndFailedToFindMsg
							}
							print("Failed decoding addUserResponseData with Msg:", retMsg)
					}

				} else {

					if let baseData = try? JSONDecoder().decode(IOTBaseResponseData.self, from: data) {
						guard let retMsg = baseData.retMsg else {
							throw HTTPNetworkError.failedToDecodingBaseResponseDataAndFailedToFindMsg
						}
						print("Failed decoding baseData with Msg:", baseData.retCode, retMsg)
					} else {
						throw HTTPNetworkError.failedToDecodingBaseResponseData
					}

				}
			} catch let taskError {
				print(taskError)
			}
		}
		task.resume()
	}

	private func makeRequest(action: HTTPNetworkRoute, data: Data) -> URLRequest? {
		do {
			guard let request = try? HTTPNetworkRequest.configureHTTPRequest(from: action,
																																			 with: [:],
																																			 includes: [:],
																																			 contains: data,
																																			 and: .post) else {
				throw HTTPNetworkError.taskErrorStopBeforeSendingRequest
			}
			return request
		} catch let requestError {
			print(requestError)
			return nil
		}
	}

}


extension IOTNetworkService: IOTCardInfoComponentsTransportDelegate {
	func transport(action: IOTNetworkRequestAction, info: IOTCardInfo) {
		let requested = IOTRequestCardData(secureId: secureId, cardInfo: info)
		guard let jsonData = try? JSONSerialization.data(withJSONObject: requested.params) else {
			fatalError()
		}

//		if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
//						// try to read out a string array
//
//			print("sending ", json)
//				}

		switch action {
			case .addCard:
				addCard(data: jsonData) { [weak self] (addCardRetData: IOTAddCardRetData) in
					let desensitizedCardInfo: IOTDesensitizedCardInfo = addCardRetData.desensitizedCardInfo
					self?.delegate?.onDidAddCard(desensitizedCardInfo: desensitizedCardInfo,
																			 redirectUrl: addCardRetData.redirectUrl)
				}
			case .oneTimePurchase:
				oneTimePurchase(data: jsonData) { [weak self] (purchaseRetData: IOTPurchaseRetData) in
					let purchaseReceipt: IOTPurchaseReceipt = purchaseRetData.purchaseReceipt
					self?.delegate?.onDidPurchase(purchaseReceipt: purchaseReceipt,
																				redirectUrl: purchaseRetData.redirectUrl)
				}
		}
	}
}


