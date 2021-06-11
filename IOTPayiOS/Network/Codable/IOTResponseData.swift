//
//  IOTResponseData.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-16.
//

import Foundation

struct IOTBaseResponseData: Codable {
	let retCode: IOTRetCode
	let retMsg: String?
}


struct IOTAddCardResponseData: Codable {
	let retData: IOTAddCardRetData
	let retCode: String
	let retMsg: String?
}

struct IOTAddCardRetData: Codable {
	let cardId: String
	let cardNum: String
	let cvv: String
	let expiryDate: String
	let holder: String
	let redirectUrl: String

	var desensitizedCardInfo: IOTDesensitizedCardInfo {
		IOTDesensitizedCardInfo(cardId: cardId, cardNumber: cardNum, holderName: holder)
	}
}

struct IOTPurchaseResponseData: Codable {
	let retData: IOTPurchaseRetData
	let retCode: IOTRetCode
	let retMsg: String?
}

struct IOTPurchaseRetData: Codable {
	let amount: Int   //Int in cent
	let	authNum: String
	let	cardNum: String // desensitizated   424242XXXXXX4242
	let	cardType: String  // V=Visa, M=Master, D=Interact
	let	currency: String //
	let	expiryDate: String // 1122;
	let invoiceNum: String // 832828793487
	let mchId: String// 10000576;
	let mchOrderNo: String// 1618569175;
	let originalOrderId: String // "";
	let payOrderId: String //CS20210416103255832828793487;
	var paySuccTime: String?// "2021-04-16 03:33:16";
	let payType: String// pay;
	let redirectUrl: String
//	// "https://develop.iotpay.ca/new/v3dev/result.php?abc=111&code=234&
//	//mchOrderNo=1618569175&retCode=SUCCESS&status=2#foude";
	let refundable: Int   //Int in cent
	let status: Int   //2
	let transNum: String   //Int= 000108583539;
	let channel: String //"UPI_EX" or "PF_CC"

	var purchaseReceipt: IOTPurchaseReceipt {
		IOTPurchaseReceipt(amount: amount, authorizationNumber: authNum, cardNumber: cardNum,
											 cardType: cardType, currency: currency, invoiceNumber: invoiceNum,
											 merchantOrderNumber: mchOrderNo, originalOrderId: originalOrderId,
											 payOrderId: payOrderId, paySuccessTime: paySuccTime, payType: payType,
											 refundable: refundable, status: status, transitionNumber: transNum)
	}

}

@objc
public class IOTPurchaseReceipt: NSObject {
	let amount: Int   //Int in cent
	let	authorizationNumber: String
	let	cardNumber: String // desensitizated   424242XXXXXX4242
	let	cardType: String  // V=Visa, M=Master, D=Interact
	let	currency: String //
	//let	expiryDate: String // 1122;
	let invoiceNumber: String // 832828793487
	//let mchId: String// 10000576;
	let merchantOrderNumber: String// 1618569175;
	let originalOrderId: String // "";
	let payOrderId: String //CS20210416103255832828793487;
	let paySuccessTime: String// "2021-04-16 03:33:16";
	let payType: String// pay;
	//let redirectUrl: String
	let refundable: Int   //Int in cent
	let status: Int   //2
	let transitionNumber: String   //Int= 000108583539;

	init(amount: Int, authorizationNumber: String, cardNumber: String, cardType: String,
			 currency: String, invoiceNumber: String, merchantOrderNumber: String,
			 originalOrderId: String, payOrderId: String, paySuccessTime: String?,
			 payType: String, refundable: Int, status: Int, transitionNumber: String) {
		self.amount = amount
		self.authorizationNumber	= authorizationNumber
		self.cardNumber = cardNumber
		self.cardType = cardType
		self.currency = currency
		self.invoiceNumber = invoiceNumber
		self.merchantOrderNumber = merchantOrderNumber
		self.originalOrderId = originalOrderId
		self.payOrderId = payOrderId
		self.paySuccessTime = paySuccessTime ?? ""
		self.payType = payType
		self.refundable = refundable
		self.status = status
		self.transitionNumber = transitionNumber

	}

	@objc
	public var info: String {
		"""
		amount: \(amount), authorizationNumber: \(authorizationNumber), cardNumber: \(cardNumber),
		cardType: \(cardType), currency: \(currency), invoiceNumber: \(invoiceNumber),
		merchantOrderNumber \(merchantOrderNumber), originalOrderId: \(originalOrderId),
		payOrderId: \(payOrderId), paySuccessTime: \(paySuccessTime), payType: \(payType),
		refundable: \(refundable), status: \(status), transitionNumber: \(transitionNumber)
		"""
	}

}

enum IOTRetCode: String, Codable {
	case SUCCESS, FAIL
	init(retCode: String) {
		if retCode == "SUCCESS" { self = .SUCCESS }
		else if retCode == "FAIL" { self = .FAIL}
		else { fatalError() }
	}
}

struct IOTNetworkResponse: Codable {
	let URL: String?
	let Status_Code: Int?
	let Headers: String?
}
