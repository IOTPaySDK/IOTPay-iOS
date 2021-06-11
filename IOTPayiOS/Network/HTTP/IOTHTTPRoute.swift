//
//  HTTPRoute.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-16.
//

public enum IOTIOTHTTPNetworkRoute: Int {
	case addCard = 0
	case oneTimePurchase
	case retryPurchase

	public init(action: IOTNetworkRequestAction) {
		self = IOTIOTHTTPNetworkRoute.init(rawValue: action.rawValue)!
	}

	public var route: String {
		if IOTNetworkRequest.isUseTestingApi {
			switch self {
				case .addCard: return "v3/cc_pfaddcard"
				case .oneTimePurchase: return "v3/cc_pfpurchase"
				case .retryPurchase: return "cc/queryorder"
			}
		} else {
			switch self {
				case .addCard: return "v3/cc_pfaddcard"
				case .oneTimePurchase: return "v3/cc_pfpurchase"
				case .retryPurchase: return "cc/queryorder"
//				case .addCard: return "v3/cc_addcard"
//				case .oneTimePurchase: return "v3/cc_purchase"
//				case .retryPurchase: return "cc/queryorder"
			}
		}

	}
}
