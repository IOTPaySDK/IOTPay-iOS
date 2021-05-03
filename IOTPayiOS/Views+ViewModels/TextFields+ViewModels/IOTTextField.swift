//
//  DeformableTextField.swift
//  IOTPayUIPlayground
//
//  Created by Dan on 2021-03-25.
//

import UIKit

protocol IOTTextFieldDelegate: AnyObject {
	func onDidSelected(textField: IOTTextFieldSubject)
	func onDidChanged(textField: IOTTextFieldSubject, text: String)
	func onDidComplete(textField: IOTTextFieldSubject, isValid: Bool)
	func onDidPredicate(cardPattern: IOTCardPatternPrediction)
}

class IOTTextField: UITextField {

	weak var textFieldDelegate: IOTTextFieldDelegate?

	var viewModel: IOTTextFieldViewModel!

	let attribute: IOTTextFieldAttribute

	// calculated var from viewModel
	var subject: IOTTextFieldSubject { viewModel.subject }
	var valueString: String?  { viewModel.valueString }
	var isValid: Bool { viewModel.validationState.isValid }

	var patternPrediction: IOTCardPatternPrediction = .unrecognized {
		didSet { viewModel.patternPrediction = patternPrediction }
	}

	var displayState: IOTTextFieldDisplayState! {
		get { return viewModel.displayState }
		set { viewModel.displayState = newValue }
	}

	//MARK: Life cycle
	init(textFieldType: IOTTextFieldSubject, attribute: IOTTextFieldAttribute) {
		self.attribute = attribute
		super.init(frame: CGRect.zero)
		setupViewModel(textFieldType: textFieldType)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {}

	func setupViewModel(textFieldType: IOTTextFieldSubject) {
		viewModel = IOTTextFieldViewModel(textFieldSubject: textFieldType)
		viewModel.delegate = self
		delegate = viewModel
		viewModel.start()
	}

	private func commonInit() {
		keyboardType = subject.keyboardType
		font = UIFont.systemFont(ofSize: 14)
		autocorrectionType = .no
	}
}


extension IOTTextField: IOTTextFieldViewModelDelegate {
	func onDidPredicate(cardPattern: IOTCardPatternPrediction) {
		textFieldDelegate?.onDidPredicate(cardPattern: cardPattern)
	}

	func onDidComplete(subject: IOTTextFieldSubject) {
		//playSingleTextFieldCompletedAnimation()
		textFieldDelegate?.onDidComplete(textField: subject, isValid: true)
	}

	
	func updateTextField(string: String?) { text = string }

	func updateTextField(color: UIColor?) { textColor = color }

	func updatePlaceholder(attributedString: NSAttributedString?) {
		attributedPlaceholder = attributedString
	}

}


//MARK: Animation
extension IOTTextField {
	private func playSingleTextFieldCompletedAnimation() {
		UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: []) { [weak self] in

			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
				self?.textColor = .green
			}

			UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
				self?.backgroundColor = .green
			}

			UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
				self?.textColor = IOTColor.normalTextColor.uiColor
				self?.backgroundColor = .clear
			}

		} completion: { (completed) in
			if completed {}
		}

	}
}











