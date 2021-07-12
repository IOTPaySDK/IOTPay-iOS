
//  IOTNetworkRequestData.swift
//  NetworkManager
//
//  Created by macbook on 2021-04-16.
//

import Foundation

struct IOTCardInfo {
	// var naming in frontend style
	let cardNumber: String
	let holderName: String
	let expiryDate: String
	let cvv: String
}

@objc
public class IOTDesensitizedCardInfo: NSObject {
	@objc
	public let cardId: String
	@objc
	public let cardNumber: String
	@objc
	public let holderName: String

	@objc
	init(cardId: String, cardNumber: String, holderName: String) {
		self.cardId = cardId
		self.cardNumber = cardNumber
		self.holderName = holderName
	}

	init(addCardRetData: IOTAddCardRetData) {
		self.cardId = addCardRetData.cardId
		self.cardNumber = addCardRetData.cardNum
		self.holderName = addCardRetData.holder
	}

	@objc
	public var info: String {
		return "cardId: \(cardId), cardNumber: \(cardNumber), holderName: \(holderName)"
	}
}



struct IOTRequestCardData {
	// var naming in backend style,
	let cvv: String
	let holder: String //50 max
	let expiryDate: String // 1212
	let cardNum: String
	let	secureId: String  //len 64

	init(secureId: String, cardInfo: IOTCardInfo) {
		self.cvv = cardInfo.cvv
		self.holder = cardInfo.holderName
		self.expiryDate = cardInfo.expiryDate
		self.cardNum = cardInfo.cardNumber
		self.secureId = secureId

		#if DEBUG
		guard secureId.count == 64 else {
			fatalError("secureId expecting string.count 64, got \(secureId.count), str: \(secureId)")
		}
		guard cvv.count == 3 || cvv.count == 4 else {
			fatalError("cvv expecting count 3 or 4, got \(cvv.count), str: \(cvv)")
		}
		guard expiryDate.count == 4 else {
			fatalError("cvv expecting count 3 or 4, got \(expiryDate.count), str: \(expiryDate)")
		}
		guard cardNum.count >= 14, cardNum.count <= 19 else {
			fatalError("cardNum expecting count 14-19, got \(cardNum.count), str: \(cardNum)")
		}
		#endif
	}

	var params: [String: String] {
		[ "cvv": cvv,
			"holder": holder,
		 "expiryDate": expiryDate,
		 "secureId": secureId,
		 "cardNum": cardNum,
		 //"loginName": "abcde",
		]
	}


}

