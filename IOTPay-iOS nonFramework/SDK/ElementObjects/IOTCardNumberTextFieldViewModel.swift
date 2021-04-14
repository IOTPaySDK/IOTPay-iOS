//
//  IOTCardNumberTextFieldViewModel.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import Foundation

//protocol Predicable {
////	func onTextFieldDidChange(text: String,
////														 prediction: IOTCardPatternPrediction,
////														 onCompletion: (IOTCardPatternPrediction) -> Void)
//	func updatePrediction(cardPattern: IOTCardPatternPrediction)
//}

//protocol IOTCardNumberTextFieldViewModelPredicationDelegate: AnyObject {
//	func onDidPredicate(cardPattern: IOTCardPatternPrediction)
//}

final class IOTCardNumberTextFieldViewModel: IOTTextFieldViewModel {
//
//	weak var predicationDelegate: IOTCardNumberTextFieldViewModelPredicationDelegate?
//
//
	let predictionModel = IOTCardPatternPredictionModel()

	override func stringWork(text: String) -> IOTTextFieldViewModel.StringWorkResult {
		var filteredText = filterModel.filtering(text: text, for: subject)
		filteredText = String(filteredText.prefix(maxLength))
		valueString = filteredText

		let cardPattern = predictionModel.predicting(cardNumberText: filteredText)
		print("cardPattern", cardPattern)
		delegate?.onDidPredicate(cardPattern: cardPattern)
//		let validation = validatorModel.validating(text: filteredText, for: subject, with: cardPattern)
//		print(cardPattern, validation)

		let validation = validatorModel.validating(text: filteredText, for: subject, with: patternPrediction)
		//let color: IOTColor = validation.state.isWrong ? .inViladTextColor : .normalTextColor

		var formattedText = formatterModel.formatting(text: filteredText, for: subject)

		print(cardPattern)

		if isBackSpaced && formattedText.count >= 1 && formattedText.last == " " {
			formattedText.removeLast()
		}

//		valueString = filteredText
//		displayStringColor = color.uiColor
//		displayString = formattedText
		isBackSpaced = false
		print(validation.error)

		return StringWorkResult(valueString: filteredText,
														displayString: formattedText,
														validationState: validation.state,
														validationError: validation.error)
	}
}

