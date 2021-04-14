//
//  IOTInputValidator.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation

final class IOTInputValidateModel {

	init() {}

	func validating(text: String, for textFieldType: IOTTextFieldSubject, with cardPatternPrediction: IOTCardPatternPrediction?) -> ValidationResult {
		switch textFieldType {
		case .holderName: return validatingHolderName(text: text)
		case .cardNumber: return validatingCardNumber(text: text, prediction: cardPatternPrediction)
		case .expiryDate: return validatingExpiryDate(text: text)
		case .cvv: return validatingCvv(text: text, prediction: cardPatternPrediction)
		}
	}

	//MARK: Name
	private func validatingHolderName(text: String) -> ValidationResult {
		if text.isEmpty || text.count <= 1 {
			return ValidationResult(state: .entering, error: [.holderNameIsTooShort])
		} else {
			return ValidationResult(state: .valid, error: [])
		}
	}


	//MARK: Card number
	private func validatingCardNumber(text: String,
																		prediction: IOTCardPatternPrediction?) -> ValidationResult {

		guard !text.isEmpty, Int(text) != nil else { return ValidationResult(state: .entering) }

		let length = text.count
		var lengthIsValid = false
		var errorSet = Set<IOTCardInfoValidationError>()

		let prefixOne = String(text.prefix(1))
		if length == 1 {
			if IOTCardNumberRegulation.firstDigitPossiblePattern[prefixOne] == nil {
				errorSet.insert(.cardNumberIsNotAssociateWithAnyBrand)
				//return ValidationResult(state: .conflict, error: [.cardNumberIsNotAssociateWithAnyBrand])
			}
		}

		let prefixTwo = String(text.prefix(2))
		if length >= 2 {
			if IOTCardNumberRegulation.firstDigitCertainPattern[prefixOne] == nil &&
				 IOTCardNumberRegulation.firstTwoDigitsCertainPattern[prefixTwo] == nil {
				errorSet.insert(.cardNumberIsNotAssociateWithAnyBrand)
			}
		}

		if let validDigits = prediction?.validCardNumberDigits {
			if length > validDigits {
				print(length, validDigits)
				errorSet.insert(.cardNumberTooLong)
			} else if length == validDigits {
				lengthIsValid = true
			} else {
				errorSet.insert(.cardNumberTooShort)
			}
		}

		print("erroer cout", errorSet.count)

		if errorSet.count == 0 && lengthIsValid {
			//todo
			return ValidationResult(state: .valid)
		} else {
			return ValidationResult(state: .entering, error: Array(errorSet))
		}
	}

	//MARK: Date
	private func validatingExpiryDate(text: String) -> ValidationResult {

		var validationState: IOTTextFieldValidationState = .entering
		var errorArray = [IOTCardInfoValidationError]()
		var isHaveSlash: Bool = false
		// get month, year if any
		let month: String?
		let year: String?
		if let slashIndex = text.firstIndex(of: "/") {
			let strBeforeSlash = text[text.startIndex..<slashIndex]
			month = String(strBeforeSlash)
			let indexAfterSlash = text.index(after: slashIndex)
			let strAfterSlash = text[indexAfterSlash..<text.endIndex]
			year = String(strAfterSlash)
			isHaveSlash = true
		} else {
			month = text
			year = nil
		}

		var yearIsValid: Bool = false
		var monthIsValid: Bool = false
//		var validationSign: IOTValidationSign = .red

		if let month = month, let intMonth = Int(month), intMonth <= 12, month.count == 2 {
			monthIsValid = true
		}

		if let year = year, Int(year) != nil, year.count == 2 {
			yearIsValid = true
		}

		if monthIsValid && yearIsValid {
			validationState = .valid
		} else {
			validationState = .entering
			errorArray.append(.cvvTooShort)
		}

		if let month = month, let intMonth = Int(month),
			 intMonth > 12 || (month.count < 2 && isHaveSlash) {
			validationState = .conflict
			errorArray.append(.cvvTooLong)
		}
		return ValidationResult(state: validationState, error: errorArray)
	}

	//MARK: Cvv
	private func validatingCvv(text: String,
														 prediction: IOTCardPatternPrediction?) -> ValidationResult {

		var validationState: IOTTextFieldValidationState = .entering
		var errors = [IOTCardInfoValidationError]()

		if let validDigit = prediction?.validCvvDigits {
			if text.count < validDigit {
				errors.append(.cvvTooShort)
				validationState = .entering
			} else if text.count > validDigit {
				errors.append(.cvvTooLong)
				validationState = .conflict
			} else {
				validationState = .valid
			}
		}
		return ValidationResult(state: validationState, error: errors)
	}

	struct ValidationResult {
		let state: IOTTextFieldValidationState
		let error: [IOTCardInfoValidationError]

		init(state: IOTTextFieldValidationState, error: [IOTCardInfoValidationError] = []) {
			self.state = state
			self.error = error
		}
	}

}
