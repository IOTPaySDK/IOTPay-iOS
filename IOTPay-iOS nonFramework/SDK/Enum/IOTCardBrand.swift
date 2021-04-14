//
//  IOTCardBrand.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

enum IOTCardBrand: String {
	case visa = "visa.png"
	case master = "mastercard.png"
	case americanExpress = "amex.png"
	case discover = "discover.png"
	case dinersClub = "diners.png"
	case unionPay = "unionpay.png"
	case jcb = "jcb.png"

	var isCurrentlySupported: Bool {
		switch self {
		case .visa, .master, .americanExpress, .discover: return true
		default: return false
		}
	}
}
