//
//  IOTTextFieldValidationState.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

import UIKit

enum IOTTextFieldValidationState {
	case valid
	case entering
	case empty
	case conflict
	case tooShort
	case tooLong

	var isValid: Bool { self == .valid ? true : false }
	var isEmpty: Bool { self == .empty ? true : false }
	var isDone: Bool { self == .entering || self == .empty ? false : true}
	var isWrong: Bool { self == .conflict || self == .tooShort || self == .tooLong ? true : false}

	var color: UIColor {
		switch self {
		case .conflict, .tooLong, .tooShort: return .systemRed
		case .empty, .entering: return .white
		case .valid: return .systemGreen
		}
	}
}
