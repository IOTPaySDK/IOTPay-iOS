//
//  TextFieldType.swift
//  IOTPay-iOS nonFramework
//
//  Created by Dan on 2021-04-07.
//

import UIKit

enum IOTTextFieldAttribute {
	case common
	case deformable
}

enum IOTTextFieldSubject: Int, CaseIterable {
	case cardNumber = 0
	case holderName
	case expiryDate
	case cvv
}

extension IOTTextFieldSubject {
	var thumbnailPlaceholder: String {
		switch self {
		case .cardNumber: return "Card No."
		case .cvv: return "CVV"
		case .expiryDate: return "MM/YY"
		case .holderName: return "Name"
		}
	}

	var normalPlaceholder: String {
		switch self {
		case .cardNumber: return "Card number"
		case .cvv: return "CVV on back"
		case .expiryDate: return "MM/YY"
		case .holderName: return "First & Last name of the holder"
		}
	}

	var isPassingFirstResponderToNext: Bool {
		switch self {
		case .cardNumber, .cvv, .expiryDate: return true
		case .holderName: return false
		}
	}

	var vaildLengthClosedRange: ClosedRange<Int> {
		switch self {
		case .cardNumber: return 13...16
		case .cvv: return 3...4
		case .expiryDate: return 5...5 //100...1299
		case .holderName: return 1...32
		}
	}

	var maxLength: Int {
		switch self {
		case .cardNumber: return 20
		case .cvv: return 4
		case .expiryDate: return 5 //100...1299
		case .holderName: return 50
		}
	}

	var keyboardType: UIKeyboardType {
		if #available(iOS 10.0, *) {
			switch self {
			case .cardNumber: return .asciiCapableNumberPad
			case .cvv: return .asciiCapableNumberPad
			case .expiryDate: return .asciiCapableNumberPad
			case .holderName: return .asciiCapable
			}
		} else {
			switch self {
			case .cardNumber: return .numberPad
			case .cvv: return .numberPad
			case .expiryDate: return .numberPad
			case .holderName: return .asciiCapable
			}
		}
	}

	func isDeformable(in cardTextFieldLayout: IOTCardInfoViewLayout) -> Bool {
		switch self {
		case .cardNumber: return cardTextFieldLayout == .singleLineWithSmallCardIcon ? true : false
		case .cvv: return false
		case .expiryDate: return false
		case .holderName: return cardTextFieldLayout == .singleLineWithSmallCardIcon ? true : false
		}
	}

	var inputOrderIndex: Int {
		switch self {
		case .cardNumber: return 1
		case .cvv: return 3
		case .expiryDate: return 2
		case .holderName: return 0
		}
	}




}

