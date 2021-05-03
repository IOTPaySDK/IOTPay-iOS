//
//  IOTCardNumberTextField.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

class IOTCardNumberTextField: IOTTextField {

	override func setupViewModel(textFieldType: IOTTextFieldSubject) {
		viewModel = IOTCardNumberTextFieldViewModel(textFieldSubject: textFieldType)
		viewModel.delegate = self
		viewModel.start()
		delegate = viewModel
	}

}
