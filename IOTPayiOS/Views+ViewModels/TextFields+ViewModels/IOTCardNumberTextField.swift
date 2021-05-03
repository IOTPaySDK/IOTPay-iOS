//
//  IOTCardNumberTextField.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

class IOTCardNumberTextField: IOTTextField {

	override func setupViewModel(textFieldType: IOTTextFieldSubject, style: IOTCardInfoViewStyle) {
		viewModel = IOTCardNumberTextFieldViewModel(textFieldSubject: textFieldType)
		viewModel.style = style
		viewModel.delegate = self
		viewModel.start()
		delegate = viewModel
	}

}
