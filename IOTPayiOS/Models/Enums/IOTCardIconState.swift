//
//  IOTCardIconState.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

enum IOTCardIconState {
	case recognized(brand: IOTCardBrand)
	case back
	case unrecognized
	case error

	var imageName: String {
		switch self {
		case .recognized(brand: let brand): return brand.rawValue
		case .back: return "cardIconCvv" //"cardCVVHalf" //"security-code.png"
		case .unrecognized: return "cardIconEmpty" //"default.png"
		case .error: return "cardFatal"
		}
	}
}

enum IOTCardSide {
	case front
	case back
	var imageName: String {
		switch self {
		case .front: return ""
		case .back: return "cardCVVHalf" //"security-code.png"
		}
	}
}

