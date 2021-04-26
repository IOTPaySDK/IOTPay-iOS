////
////  IOTExpiryDateTextFieldViewModel.swift
////  IOTPay-iOS nonFramework
////
////  Created by macbook on 2021-04-12.
////
//
//class IOTExpiryDateTextFieldViewModel: IOTTextFieldViewModel {
//
////	override func stringWork(text: String) -> IOTTextFieldViewModel.StringWorkResult {
////
////
////		var filteredText = filterModel.filtering(text: text, for: subject)
////		filteredText = String(filteredText.prefix(maxLength))
////
////
////
//	override var valueString: String {
//		willSet {
//			print(newValue)
//		}
//		didSet {
//			print(valueString)
//		}
//	}
////
////
////		let validation = validatorModel.validating(text: filteredText, for: subject, with: patternPrediction)
////		//let color: IOTColor = validation.state.isWrong ? .inViladTextColor : .normalTextColor
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
////														validationState: validation.state,
////														validationError: validation.error)
////	}
//
//
//}
