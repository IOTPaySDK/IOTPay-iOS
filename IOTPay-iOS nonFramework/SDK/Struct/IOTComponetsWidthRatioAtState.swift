//
//  File.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import UIKit

struct IOTDeformConfig {
	let initDisplayState: [IOTTextFieldDisplayState]
	let nilSeletionRatios: [CGFloat]
	let cardNumberRatios: [CGFloat]?
	let holderNameRatios: [CGFloat]?
	let expiryDateRatios: [CGFloat]?
	let cvvRatios: [CGFloat]?

	init(initDisplayState: [IOTTextFieldDisplayState],
			 nilSeletionRatios: [CGFloat],
			 cardNumberRatios: [CGFloat]? = nil,
			 holderNameRatios: [CGFloat]? = nil,
			 expiryDateRatios: [CGFloat]? = nil,
			 cvvRatios: [CGFloat]? = nil) {
		self.initDisplayState = initDisplayState
		self.nilSeletionRatios = nilSeletionRatios
		self.holderNameRatios = holderNameRatios
		self.cardNumberRatios = cardNumberRatios
		self.expiryDateRatios = expiryDateRatios
		self.cvvRatios = cvvRatios

		#if DEBUG
			let viladLength = IOTTextFieldSubject.allCases.count
			guard initDisplayState.count == viladLength,
						nilSeletionRatios.count == viladLength,
						holderNameRatios == nil || holderNameRatios!.isEmpty ||
							holderNameRatios!.count == viladLength,
						cardNumberRatios == nil || cardNumberRatios!.isEmpty ||
							cardNumberRatios!.count == viladLength,
						expiryDateRatios == nil || expiryDateRatios!.isEmpty ||
							expiryDateRatios!.count == viladLength,
						cvvRatios == nil || cvvRatios!.isEmpty ||
							cvvRatios!.count == viladLength
						else { fatalError() }
		#endif
	}

	func ratios(forState: IOTTextFieldSubject?) -> [CGFloat] {
		switch forState {
		case .holderName:
			return holderNameRatios ?? nilSeletionRatios
		case .cardNumber:
			return cardNumberRatios ?? nilSeletionRatios
		case .expiryDate:
			return expiryDateRatios ?? nilSeletionRatios
		case .cvv:
			return cvvRatios ?? nilSeletionRatios
		default:
			return nilSeletionRatios
		}
	}
}
