////
////  IOTHolderNameTextField.swift
////  IOTPay-iOS nonFramework
////
////  Created by macbook on 2021-04-09.
////
//
//import UIKit
//
////class HolderNameTextField: IOTTextField {
//////	init(cardTextFieldLayout: CardTextFieldLayout) {
//////		super.init(cardTextFieldLayout: cardTextFieldLayout, textFieldType: .holderName)
//////	}
////
////	init(attribute: IOTTextFieldAttribute) {
////		super.init(textFieldType: .holderName, attribute: attribute)
////	}
////
////	required init?(coder: NSCoder) {
////		fatalError("init(coder:) has not been implemented")
////	}
////}
//
//class IOTHolderNameTextFieldViewModel: IOTTextFieldViewModel {
//
//}
//
//extension IOTHolderNameTextFieldViewModel {
//	override func textField(_ textField: UITextField,
//								 shouldChangeCharactersIn range: NSRange,
//								 replacementString string: String) -> Bool {
//
//		if let text = self.valueString as NSString? {
//			valueString = text.replacingCharacters(in: range, with: string)
//		}
//
//		//var filteredText = filterModel.filtering(text: text, for: subject)
//		//onTextFieldDidChange(text: )
//
//		if let char = string.cString(using: String.Encoding.utf8) {
//			let isBackSpace = strcmp(char, "\\b")
//			if (isBackSpace == -92) { // ("Backspace was pressed")
////				if let text = text, !text.isEmpty, let lastChar = text.last, lastChar == "/" {
////					//self.text = ""
////				}
//			}
//		}
//		return true
//	}
//}
//
//
