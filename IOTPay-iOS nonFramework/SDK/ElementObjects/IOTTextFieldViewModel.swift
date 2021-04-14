//
//  IOTTextFieldViewModel.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

import Foundation
import UIKit

protocol IOTTextFieldViewModelDelegate {
	//func updateTextField(text: String, with textColor: IOTColor?)
	//func updateTextField(attributedString: NSAttributedString?)
	func updateTextField(string: String?)
	func updateTextField(color: UIColor?)
	func updatePlaceholder(attributedString: NSAttributedString?)

	func onDidComplete(subject: IOTTextFieldSubject)

	func onDidPredicate(cardPattern: IOTCardPatternPrediction)
}

class IOTTextFieldViewModel: NSObject {

	var delegate: IOTTextFieldViewModelDelegate?

	let filterModel = IOTInputFilterModel()
	let validatorModel = IOTInputValidateModel()
	let formatterModel = IOTOutputFormatModel()
	//init
	let subject: IOTTextFieldSubject

	var patternPrediction: IOTCardPatternPrediction = .unrecognized
	var validationState: IOTTextFieldValidationState = .empty
	var valueString: String = ""
	var isBackSpaced = false

	var maxLength: Int { subject.maxLength }
	var inputOrderIndex: Int { subject.inputOrderIndex }
	var nextTextFieldIndex: Int { subject.inputOrderIndex + 1 }
	var isValid: Bool = false { didSet { delegate?.onDidComplete(subject: subject) }}

	/// binding with delegate,  either RxSwift or Combine will make binding make things elegant and easier,
	/// but we're either not using RxSwift for user's convince, nor  using Combine for compatibility
	/// will use Combine in the futrue when only support iOS 13.0 +
	var attributedPlaceholder: NSAttributedString? {
		didSet { delegate?.updatePlaceholder(attributedString: attributedPlaceholder) }
	}
	var displayString: String? { didSet { delegate?.updateTextField(string: displayString) }}
	var displayStringColor: UIColor? {
		didSet { delegate?.updateTextField(color: displayStringColor) }
	}

	var displayState: IOTTextFieldDisplayState! {
		didSet {
			let placeholderString = displayState == .full ?
				subject.normalPlaceholder : subject.thumbnailPlaceholder
			attributedPlaceholder = attributedString(text: placeholderString, with: .placeholderTextColor)
		}
	}

	init(textFieldSubject: IOTTextFieldSubject) { subject = textFieldSubject }

	func start() {}

	//MARK: for override in subclass
	func stringWork(text: String) -> StringWorkResult {

		// filter
		var filteredText = filterModel.filtering(text: text, for: subject)
		filteredText = String(filteredText.prefix(maxLength))

		let validation = validatorModel.validating(text: filteredText,
																							 for: subject,
																							 with: patternPrediction)

		let formattedText: String

		if subject == .expiryDate && isBackSpaced {
			formattedText = filteredText
		} else {
			formattedText = formatterModel.formatting(text: filteredText, for: subject)
		}
		
		valueString = filteredText
		displayString = formattedText
		isBackSpaced = false

		return StringWorkResult(valueString: filteredText,
														displayString: formattedText,
														validationState: validation.state,
														validationError: validation.error)
	}
}

//MARK: Input Handler, target
extension IOTTextFieldViewModel {
	@objc func onTextFieldDidChange(sender: IOTTextField) { // first responser
		guard let text = sender.text else { return }

		var color: IOTColor
		let result: StringWorkResult = stringWork(text: text)

		if result.validationState.isValid {  // oh yeah
			//check
			guard result.validationError.count == 0 else { fatalError() } //remove
			color = .normalTextColor
			isValid = true
		} else {
			var occurredErrors = [IOTCardInfoValidationError]()
			var unfinishedErrors = [IOTCardInfoValidationError]()

			for error in result.validationError {
				if error.isFatal {
					occurredErrors.append(error)
				} else {
					unfinishedErrors.append(error)
				}
			}

			color = occurredErrors.isEmpty ? .normalTextColor : .inViladTextColor
		}

		valueString = result.valueString
		displayString = result.displayString
		displayStringColor = color.uiColor
		isBackSpaced = false
	}

}

//MARK: Input Handler, Delegates
extension IOTTextFieldViewModel: UITextFieldDelegate {
	func textField(_ textField: UITextField,
								 shouldChangeCharactersIn range: NSRange,
								 replacementString string: String) -> Bool {

		if let char = string.cString(using: String.Encoding.utf8) {
			let isBackSpace = strcmp(char, "\\b")
			if (isBackSpace == -92) { // ("Backspace was pressed")
				isBackSpaced = true
			}
		}

		return true
	}

//	func textFieldDidEndEditing(_ textField: UITextField) {
//		print("end diting", subject)
//	}
//
//	func textFieldShouldClear(_ textField: UITextField) -> Bool {
//		print("textFieldShouldClear", subject)
//		return true
//	}
//
//	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//		print("textFieldShouldClear", subject)
//		return true
//	}

}

//MARK: local helper
extension IOTTextFieldViewModel {
	private func attributedString(text: String, with textColor: IOTColor) -> NSAttributedString {
		let attributes = [NSAttributedString.Key.foregroundColor: IOTColor.placeholderTextColor.uiColor]
		return NSAttributedString(string: text, attributes:attributes)
	}
}

//extension IOTTextFieldViewModel {
//	private func playCompleteAnimation() {
//		//todo
//		
//	}
//}

//MARK: local struct
extension IOTTextFieldViewModel {
	struct StringWorkResult {
		let valueString: String
		let displayString: String
		let validationState: IOTTextFieldValidationState
		let validationError: [IOTCardInfoValidationError]
	}
}



