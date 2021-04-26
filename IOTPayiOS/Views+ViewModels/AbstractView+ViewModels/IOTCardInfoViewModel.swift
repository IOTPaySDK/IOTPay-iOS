//
//  IOTCardInfoViewModel.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation
import UIKit

protocol IOTCardInfoViewModelDelegate {
	func updatingComposition(fromSelection: IOTTextFieldSubject, toSeletion: IOTTextFieldSubject, aimation: Bool)
	func updatingImageIcon(to state: IOTCardIconState)
}

class IOTCardInfoViewModel {

	var delegate: IOTCardInfoViewModelDelegate?

	private var cardPatternPrediction: IOTCardPatternPrediction = .unrecognized {
		didSet { delegate?.updatingImageIcon(to: cardPatternPrediction.cardIconDisplayState) }
	}

	private weak var selectedTextField: IOTTextField? = nil {
		didSet {
		}
	}


	
}

//MARK: Input handler
extension IOTCardInfoViewModel {

//	@objc func onTextFieldDidSelect(sender: IOTTextField) {
//		selectedTextField = sender //IOTTextFieldSubject(rawValue: sender.inputOrderIndex)
//	}
//
//
//
//	@objc func onTextFieldDidChange(sender: IOTTextField) {
//
//		if isValid { // job done}
//			seletedTextField.
//		}
//
//		if sender.isValid {  // forcous on next
//			sender.textColor = .black
//			if sender.nextTextFieldIndex < textFieldsay.count {
//				seletedTextField = textFieldsay[sender.nextTextFieldIndex].subject
//			} else {
//				// end of input,last one is filled, but still need valid check
//			}
//		}
//
//		sender.viewModel.onTestUpdate(text: sender.text, cardPatternPrediction: cardPatternPrediction)
//
//	}

}
