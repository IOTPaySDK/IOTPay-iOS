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

	var apiSuffix: String {
		switch self {
			case .addCard: return "/cc_pfadduser"
			case .oneTimePurchase: return "/cc_pfpurchase"
		}
	}
}

public final class IOTNetworkRequest {

	// constant
	private let apiPrefix: String = "https://ccdev.iotpaycloud.com/v3"

	// init constant
	let action: IOTNetworkRequestAction
	let cardInfo: IOTRequestCardData

	private var apiSuffix: String { action.apiSuffix }
	private var url: URL { URL(string: apiPrefix + apiSuffix)! }
	var urlRequest: URLRequest { URLRequest(url: url) }

	init(secureId: String, action: IOTNetworkRequestAction, cardInfo: IOTCardInfo) {
		self.action = action
		self.cardInfo = IOTRequestCardData(secureId: secureId, cardInfo: cardInfo)
	}
}
