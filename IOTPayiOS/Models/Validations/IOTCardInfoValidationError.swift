//
//  IOTCardInfoInputError.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

enum IOTCardInfoValidationError: String {
	case cardNumberTooLong
	case cardNumberTooShort
	case cardNumberIsNotAssociateWithAnyBrand
	case holderNameIsTooShort
	case expiryDateMonthIsInvalid
	case expiryDateIsTooShort
	case cvvTooShort
	case cvvTooLong


	var asscoiatedTextField: IOTTextFieldSubject {
		switch self {
			case .cardNumberTooLong: return .cardNumber
			case .cardNumberTooShort: return .cardNumber
			case .cardNumberIsNotAssociateWithAnyBrand: return .cardNumber
			case .holderNameIsTooShort: return .holderName
			case .expiryDateMonthIsInvalid: return .expiryDate
			case .expiryDateIsTooShort: return .expiryDate
			case .cvvTooShort: return .cvv
			case .cvvTooLong: return .cvv
		}
	}

	var isFatal: Bool {
		switch self {
			case .cardNumberTooLong: return true
			case .cardNumberTooShort: return false
			case .cardNumberIsNotAssociateWithAnyBrand: return true
			case .holderNameIsTooShort: return false
			case .expiryDateMonthIsInvalid: return true
			case .expiryDateIsTooShort: return false
			case .cvvTooShort: return false
			case .cvvTooLong: return true
		}
	}
}
