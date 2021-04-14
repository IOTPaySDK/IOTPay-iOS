//
//  IOTInputFilter.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation


final class IOTInputFilterModel {

	init() {}

	func filtering(text: String?, for textFieldType: IOTTextFieldSubject) -> String {
		
		guard let text = text else {
			return ""
		}

		switch textFieldType {
		case .holderName:
			return retainAscii(text: text)
		case .cardNumber:
			return retainNumerical(text: text)
		case .expiryDate:
			let str = retainNumericalAndForwardSlash(text: text)
			return retainFirst(char: "/", in: str)
		case .cvv:
			return retainNumerical(text: text)
		}
	}

	private func retainNumerical(text: String) -> String {
		text.components(separatedBy: CharSet.numbericalFilter).joined()
	}

	private func retainNumericalAndForwardSlash(text: String) -> String {
		text.components(separatedBy: CharSet.dateFilter).joined()
	}

	private func retainAscii(text: String) -> String {
		text.components(separatedBy: CharSet.englishCharFilter).joined()
	}

	private func retainFirst(char: Character, in text: String) -> String {
		if var firstSlashIndex = text.firstIndex(of: char) {
			text.formIndex(after: &firstSlashIndex)
			var result = text
			result.replaceSubrange(firstSlashIndex...,
														 with: result[firstSlashIndex...].filter { $0 != "/" })
			return result
		} else {
			return text
		}
	}

}
