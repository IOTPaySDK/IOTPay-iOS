//
//  IOTColor.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import UIKit

enum IOTColor {
	case normalTextColor
	case inViladTextColor
	case validTextColor
	case placeholderTextColor
	case system5
	case roundRectBoderColorBlue
	case roundRectBoderColorGray


	var uiColor: UIColor {
		switch self {
			case .normalTextColor:
				return UIColor.black
			case .inViladTextColor:
				return UIColor.systemRed
			case .validTextColor:
				return UIColor.systemGreen
			case .placeholderTextColor:
				return UIColor.gray
			case .system5:
				if #available(iOS 13.0, *) {
					return UIColor.systemGray5
				} else {
					return uiColor255(with: 229, green: 229, blue: 234, alpha: 1.0)
				}
			case .roundRectBoderColorBlue:
				return uiColor255(with: 1, green: 111, blue: 208, alpha: 1.0)
			case .roundRectBoderColorGray:
				return uiColor255(with: 229, green: 229, blue: 234, alpha: 1.0)
		}
	}

	func uiColor255(with red: Int, green: Int, blue: Int, alpha: CGFloat?) -> UIColor {
		UIColor(red: CGFloat(red) / 255.0,
						green: CGFloat(green) / 255.0,
						blue: CGFloat(blue) / 255.0,
						alpha: CGFloat(alpha ?? 1))
	}
}
