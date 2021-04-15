//
//  IOTNetworkManager.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation

protocol IOTNetworkManagerDelegate {
	func didRespond(isSuccess: Bool, response: IOTNetworkResponse, error: IOTNetworkError)
}

public final class IOTNetworkManager {

	public static let shared = IOTNetworkManager()

	private init() {}

	private var secureId: String?

	public func sendRequest(secureId: String, cardInfoPrivder: IOTCardInfoView) {
		self.secureId = secureId
		let core = cardInfoPrivder.facade.viewComponents
		core.transportDelegate = self
		core.transport()
	}

//	public func confirmAction() {
//		sendRequest(secureId: , cardInfoPrivder: )
//	}

	private func startSession(request: IOTNetworkRequest) {
		let jsonData = try? JSONSerialization.data(withJSONObject: request.cardInfo)
		// create post request
		let url = URL(string: request.url)!
		let action = request.action
		//let url = URL(string: "http://httpbin.org/post")!
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		// insert json data to the request
		request.httpBody = jsonData


		let task = URLSession.shared.dataTask(with: request) { data, response, error in
				guard let data = data, error == nil else {
						print("ERROR:", error?.localizedDescription ?? "No data")
						return
				}
				let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

				if let responseJSON = responseJSON as? [String: Any] {
					print("got \(action) responseJSON:", responseJSON)

					switch action {
					case .addCard: break
//						if let paramDict = responseJSON["payParams"] as? [String: String],
//							 let secureId = paramDict["secureID"] {
//								self.onAddUserResponse(id: secureId)
//						} else {
//							 print("not string arr")
//						}
//					case .pfadduser: break
//					case .purchase:
//						if let paramDict = responseJSON["payParams"] as? [String: String],
//							 let secureId = paramDict["secureID"] {
//								self.onOneTimePayResponse(id: secureId)
//						} else {
//							print("not string arr")
//						}
					case .oneTimePurchase: break
					}

//					switch event {
//					case .addUser:
//						if let paramDict = responseJSON["payParams"] as? [String: String] {
//							if let secureId = paramDict["secureID"] {
//								self.secureId = secureId
//								self.onFirstResponse(id: secureId)
//							}
//						} else {
//							print("not string arr")
//						}
//
//					case .pfadduser:
//						print("response in pfadduser :=====",responseJSON)
//					case .purchase:
//						print("response in purchase :=====",responseJSON)
//						if let paramDict = responseJSON["payParams"] as? [String: String] {
//							if let secureId = paramDict["secureID"] {
//								print("in purchase id", secureId)
//								//self.secureId = secureId
//								self.onFirstResponse(id: secureId)
//							}
//						} else {
//							print("not string arr")
//						}
//					case .pfpurchase:
//						print("aaaaaa?")
//						print("response in pfpurchase :=====",responseJSON)
//					}

				}
		}

	task.resume()

	}

}

extension IOTNetworkManager: IOTCardInfoComponentsTransportDelegate {
	func transport(action: IOTNetworkRequestAction, info: IOTCardInfo) {
		startSession(request: IOTNetworkRequest(secureId: secureId ?? "",
																						action: action,
																						cardInfo: info))
	}


}

struct IOTNetworkResponse {

}

enum IOTNetworkError {

}

