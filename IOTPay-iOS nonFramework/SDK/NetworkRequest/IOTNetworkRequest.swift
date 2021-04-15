//
//  IOTPayNetworkRequest.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation

enum IOTNetworkRequestAction {
	case addCard
	case oneTimePurchase
}

public final class IOTNetworkRequest {

	// constant
	private let addUserUrl = "https://ccdev.iotpaycloud.com/v3/cc_pfadduser"
	private let oneTimePurchaseUrl = "https://ccdev.iotpaycloud.com/v3/cc_pfpurchase"

	// init constant
	let action: IOTNetworkRequestAction
	let cardInfo: IOTNetworkRequestedInfo

	// var
	var url: String { action == .addCard ? addUserUrl : oneTimePurchaseUrl }


	init(secureId: String, action: IOTNetworkRequestAction, cardInfo: IOTCardInfo) {
		self.action = action
		self.cardInfo = IOTNetworkRequestedInfo(secureId: secureId, cardInfo: cardInfo)
		commonInit()
	}

//	convenience init(secureId: String, cardInfoPrivder: IOTCardInfoView) {
//		self.init(secureId: secureId,
//							action: cardInfoPrivder.action,
//							cardInfo: cardInfoPrivder.viewComponents.cardInfo)
//	}




	private func commonInit() {

	}

	struct IOTCardData {
		let cardNumber: String
		let holderName: String
		let expiryDate: String
		let cvv: String
		var params: [String: String] {
			["number": cardNumber,
			 "holder": holderName,
			 "expiryDate": expiryDate,
			 "cvv": cvv,]
		}




		//request(data: param, event: .pfadduser, type: "POST")
	}
}
