//
//  IOTCardPrediction.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

enum IOTCardPatternPrediction {
	case unrecognized
	case visa13
	case visa16
	case master
	case americanExpress
	case discover
	case dinersClub14
	case dinersClub16
	case unionPay
	case jcb
	case error

	var validCardNumberDigits: Int? {
		switch self {
		case .unrecognized: return nil
		case .visa13: return 13
		case .visa16: return 16
		case .master: return 16
		case .americanExpress: return 15
		case .discover: return 16
		case .dinersClub14: return 14
		case .dinersClub16: return 16
		case .unionPay: return 16
		case .jcb: return 16
		case .error: return nil
		}
	}

	var validCvvDigits: Int {
		switch self {
		case .unrecognized: return -1
		case .master: return 4
		default: return 3
		}
	}

	var brand: IOTCardBrand? {
		switch self {
		case .unrecognized: return nil
		case .visa13: return .visa
		case .visa16: return .visa
		case .master: return .master
		case .americanExpress: return .americanExpress
		case .discover: return .discover
		case .dinersClub14: return .dinersClub
		case .dinersClub16: return .dinersClub
		case .unionPay: return .unionPay
		case .jcb: return .jcb
		case .error: return nil
		}
	}

	var cardIconDisplayState: IOTCardIconState {
		switch self {
		case .unrecognized: return .unrecognized
		case .visa13: return .recognized(brand: .visa)
		case .visa16: return .recognized(brand: .visa)
		case .master: return .recognized(brand: .master)
		case .americanExpress: return .recognized(brand: .americanExpress)
		case .discover: return .recognized(brand: .discover)
		case .dinersClub14: return .recognized(brand: .dinersClub)
		case .dinersClub16: return .recognized(brand: .dinersClub)
		case .unionPay: return .recognized(brand: .unionPay)
		case .jcb: return .recognized(brand: .jcb)
		case .error: return .error
		}
	}

}
