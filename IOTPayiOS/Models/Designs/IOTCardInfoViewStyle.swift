//
//  IOTCardInfoViewLayout.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import Foundation

public enum IOTCardInfoViewLayout {
	case singleLineWithSmallCardIcon
	case tripleLineOnLargeCardView
	case tripleLineWithLargeCardViewOnTop
	case tripleLineWithLargeCardIconOnLeft

	var isDisplayingCardIcon: Bool {
		switch self {
		case .singleLineWithSmallCardIcon,
				 .tripleLineWithLargeCardIconOnLeft:
			return true
		case .tripleLineOnLargeCardView,
				 .tripleLineWithLargeCardViewOnTop:
			return false
		}
	}

	var isDisplayingCardView: Bool {
		switch self {
		case .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardViewOnTop,
				 .tripleLineOnLargeCardView:
			return true
		case .singleLineWithSmallCardIcon:
			return false
		}
	}

	var textFieldAttribute: IOTTextFieldAttribute {
		switch self {
		case .singleLineWithSmallCardIcon,
				 .tripleLineWithLargeCardViewOnTop,
				 .tripleLineOnLargeCardView:
				 return .deformable
		case .tripleLineWithLargeCardIconOnLeft:
			return .common
		}
	}

	var isTextFieldAnimating: Bool {
		switch self {
		case .singleLineWithSmallCardIcon:
				 return true
		case .tripleLineOnLargeCardView,
				 .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardViewOnTop:
			return false
		}
	}

	var isCardAnimating: Bool {
		switch self {
		case .singleLineWithSmallCardIcon:
				 return false
		case .tripleLineOnLargeCardView,
				 .tripleLineWithLargeCardIconOnLeft,
				 .tripleLineWithLargeCardViewOnTop:
			return true
		}
	}
}

@objc
public enum IOTCardInfoViewStyle: Int {
	case autoDarkModeSupport = 0
	case forceLightMode
	case forceDarkMode
}
