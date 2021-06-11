//
//  IOTPayNetworkRequest.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation


@objc
public enum IOTNetworkRequestAction: Int {
	case addCard = 0
	case oneTimePurchase
	//case retryPurchase

	var apiSuffix: String {
		switch self {
			case .addCard: return IOTIOTHTTPNetworkRoute.addCard.route // "v3/cc_pfadduser"
			case .oneTimePurchase: return IOTIOTHTTPNetworkRoute.oneTimePurchase.route
			//case .retryPurchase: return IOTHTTPNetworkRoute.retryPurchase.rawValue
		}
	}
}

public final class IOTNetworkRequest {

	// constant
	static let isUseTestingApi = false
	static var apiPrefix: String {
		isUseTestingApi ? testPrefix : prefix
	}
	static let prefix: String = "https://ccapi.iotpaycloud.com/"
	static let testPrefix: String = "https://ccdev.iotpaycloud.com/"

	// init constant
	let route: IOTIOTHTTPNetworkRoute
	let cardInfo: IOTRequestCardData

	private var apiSuffix: String { route.route }
	private var url: URL { URL(string: IOTNetworkRequest.apiPrefix + apiSuffix)! }
	var urlRequest: URLRequest { URLRequest(url: url) }

	init(secureId: String, route: IOTIOTHTTPNetworkRoute, cardInfo: IOTCardInfo) {
		self.route = route
		self.cardInfo = IOTRequestCardData(secureId: secureId, cardInfo: cardInfo)
	}
}
