//
//  IOTCardNumberTextField.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

//protocol IOTCardNumberTextFieldDelegate: AnyObject {
//	func onDidPredicate(cardPattern: IOTCardPatternPrediction)
//}


class IOTCardNumberTextField: IOTTextField {


	//weak var cardNumberTextFieldDelegate: IOTCardNumberTextFieldDelegate?

	override func setupViewModel(textFieldType: IOTTextFieldSubject) {
		viewModel = IOTCardNumberTextFieldViewModel(textFieldSubject: textFieldType)
			//IOTTextFieldViewModel(textFieldSubject: textFieldType)
//		if let viewModel = viewModel as? IOTCardNumberTextFieldViewModel {
//			viewModel.predicationDelegate = self
//		}
		viewModel.delegate = self
		viewModel.start()
		delegate = viewModel
	}

}
