//
//  IOTCardInfoViewLayout.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import Foundation

enum IOTCardInfoViewLayout {
	case singleLineWithSmallCardIcon
	case tripleLine
	case tripleLineWithLargeCardIconOnTop
	case tripleLineWithLargeCardIconOnLeft

	var isDisplayingCardIcon: Bool {
		switch self {
		case .singleLineWithSmallCardIcon,
				 .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardIconOnTop:
			return true
		case .tripleLine:
			return false
		}
	}

	var textFieldAttribute: IOTTextFieldAttribute {
		switch self {
		case .singleLineWithSmallCardIcon:
				 return .deformable
		case .tripleLine,
				 .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardIconOnTop:
			return .common
		}
	}

	var isTextFieldAnimating: Bool {
		switch self {
		case .singleLineWithSmallCardIcon:
				 return true
		case .tripleLine,
				 .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardIconOnTop:
			return false
		}
	}

	var isCardAnimating: Bool {
		switch self {
		case .singleLineWithSmallCardIcon:
				 return false
		case .tripleLine,
				 .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardIconOnTop:
			return true
		}
	}
}

enum IOTCardInfoViewStyle {
	case roundRect
	case infoLight
	case infoDark
}
