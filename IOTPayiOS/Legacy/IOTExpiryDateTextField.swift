////
////  IOTExpiryDateTextField.swift
////  IOTPay-iOS nonFramework
////
////  Created by macbook on 2021-04-07.
////
//
//import UIKit
//
//class IOTExpiryDateTextField: IOTTextField {
//
////	var month: String? {
////		didSet {
////			displayString = ""
////			valueString = ""
////		}
////	}
////	var year: String? {
////		didSet {
////			displayString = ""
////			valueString = ""
////		}
////	}
//
////override var valueString: String?  { viewModel.valueString }
//
//	override func setupViewModel(textFieldType: IOTTextFieldSubject) {
//		viewModel = IOTExpiryDateTextFieldViewModel(textFieldSubject: textFieldType)
//			//IOTTextFieldViewModel(textFieldSubject: textFieldType)
//		viewModel.delegate = self
//		viewModel.start()
//		delegate = viewModel
//	}
//
////	init(attribute: IOTTextFieldAttribute) {
////		
////		super.init(textFieldType: .expiryDate, attribute: attribute)
////		//delegate = self
////	}
//
////	required init?(coder: NSCoder) {
////		fatalError("init(coder:) has not been implemented")
////	}
//
//
//}
////
////class IOTExpiryDateTextFieldViewModel: IOTTextFieldViewModel {
////
////	override func stringWork(text: String) -> IOTTextFieldViewModel.StringWorkResult {
////
////		var validationState: IOTTextFieldValidationState = .entering
////		var errorArray = [IOTCardInfoValidationError]()
////
////		var filteredText = filterModel.filtering(text: text, for: subject)
////		filteredText = String(filteredText.prefix(maxLength))
////
////		var isHaveSlash: Bool = false
////		// get month, year if any
////		let month: String?
////		let year: String?
////		if let slashIndex = filteredText.firstIndex(of: "/") {
////			let strBeforeSlash = filteredText[filteredText.startIndex..<slashIndex]
////			month = String(strBeforeSlash)
////			let indexAfterSlash = filteredText.index(after: slashIndex)
////			let strAfterSlash = filteredText[indexAfterSlash..<filteredText.endIndex]
////			year = String(strAfterSlash)
////			isHaveSlash = true
////		} else {
////			month = filteredText
////			year = nil
////		}
////
////		var yearIsValid: Bool = false
////		var monthIsValid: Bool = false
////		var validationSign: IOTValidationSign = .red
////
////		if let month = month, let intMonth = Int(month), intMonth <= 12, month.count == 2 {
////			monthIsValid = true
////		}
////
////		if let year = year, Int(year) != nil, year.count == 2 {
////			yearIsValid = true
////		}
////
////		if monthIsValid && yearIsValid {
////			validationState = .valid
////		} else {
////			validationState = .entering
////			errorArray.append(.cvvTooShort)
////		}
////
////		if let month = month, let intMonth = Int(month),
////			 intMonth > 12 || (month.count < 2 && isHaveSlash) {
////			validationState = .conflict
////			errorArray.append(.cvvTooLong)
////		}
////
////
////
////		let validation = validatorModel.validating(text: filteredText, for: subject, with: patternPrediction)
////		let color: IOTColor = validation.state.isWrong ? .inViladTextColor : .normalTextColor
////
////		let formattedText: String
////		if subject == .expiryDate && isBackSpaced {
////			formattedText = filteredText
////		} else {
////			formattedText = formatterModel.formatting(text: filteredText, for: subject)
////		}
////
////		return StringWorkResult(valueString: filteredText,
////														displayString: formattedText,
////														validationState: validationState,
////														validationError: errorArray)
////	}
////
////
////}
////
//////extension ExpiryDateTextField: UITextFieldDelegate {
//////	func textField(_ textField: UITextField,
//////								 shouldChangeCharactersIn range: NSRange,
//////								 replacementString string: String) -> Bool {
//////		viewModel.onTextFieldDidChange(text: , prediction: )
//////
//////			let isBackSpace = strcmp(char, "\\b")
//////			if (isBackSpace == -92) { // ("Backspace was pressed")
//////				if let text = text, !text.isEmpty, let lastChar = text.last, lastChar == "/" {
//////					//self.text = ""
//////				}
//////			}
//////		}
//////		return true
//////	}
//////}
////
////
////enum IOTValidationSign {
////	case red
////	case green
////	case neutral
////}
