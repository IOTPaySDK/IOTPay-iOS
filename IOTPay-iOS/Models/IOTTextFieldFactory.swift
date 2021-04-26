//
//  IOTTextFieldFactory.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import UIKit

final class IOTTextFieldFactory {

	init() {}
	
	deinit {}

	func makeTextFieldArray(subjectSequence: [IOTTextFieldSubject]?,
													attributeSequence: [IOTTextFieldAttribute]) -> [IOTTextField] {

		var textFields = [IOTTextField]()
		var attributeArray = [IOTTextFieldAttribute]()

		if let subjectSequence = subjectSequence, !subjectSequence.isEmpty {
			guard attributeSequence.count == 1 || attributeSequence.count == subjectSequence.count else {
				fatalError("if subjectSequence is not nil, attribute count should be either same as subjectSequnce, or just one for shorthand")
			}

			if attributeSequence.count == 1 {
				attributeArray = Array(repeating: attributeSequence[0], count: attributeArray.count)
			}

			for i in 0..<subjectSequence.count {
				let textField = makeTextField(subject: subjectSequence[i], attribute: attributeArray[i])
				textFields.append(textField)
			}

		} else {
			guard attributeSequence.count == 1 ||
							attributeSequence.count == IOTTextFieldSubject.allCases.count else {
				fatalError("if subjectSequence is nil, attribute count should be either same as default subjectSequnce count \(IOTTextFieldSubject.allCases.count), or just one for shorthand")
			}
		}

		if attributeSequence.count == 1 {
			attributeArray = Array(repeating: attributeSequence[0],
														 count: IOTTextFieldSubject.allCases.count)
		}

		for i in 0..<IOTTextFieldSubject.allCases.count {
			let subject = IOTTextFieldSubject.init(rawValue: i)!
			let textField = makeTextField(subject: subject, attribute: attributeArray[i])
			textFields.append(textField)
		}

		return textFields
	}

	private func makeTextField(subject: IOTTextFieldSubject,
										 attribute: IOTTextFieldAttribute) -> IOTTextField {
		switch subject {
		case .cardNumber:
			return IOTCardNumberTextField(textFieldType: .cardNumber, attribute: attribute)
		case .holderName:
			return IOTTextField(textFieldType: .holderName, attribute: attribute)
		case .expiryDate:
			return IOTTextField(textFieldType: .expiryDate, attribute: attribute)
		case .cvv:
			return IOTTextField(textFieldType: .cvv, attribute: attribute)
		}
	}
}


