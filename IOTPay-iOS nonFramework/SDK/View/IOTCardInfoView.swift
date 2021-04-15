//
//  IOTCardInfoView.swift
//  IOTPayUIPlayground
//
//  Created by macbook on 2021-04-05.
//

import UIKit

public class IOTCardInfoView: UIView {
	var facade: IOTCardInfoComponentsFacade!
	//MARK: Constants
	// init constants
	let action: IOTNetworkRequestAction
	let layout: IOTCardInfoViewLayout
	// default constatns

	// models
	let viewModel: IOTCardInfoViewModel

	//MARK: ViewElements
	//var viewComponents: IOTCardInfoComponents!
//	private var cardNumberTextField = CardNumberTextField()
//	private var holderNameTextField = HolderNameTextField()
//	private var expiryDateTextField = ExpiryDateTextField()
//	private var cvvTextField = CvvTextField()
//	private var cardIconView: IOTCardIconView?


	// calculated var
	var screenW: CGFloat { UIScreen.main.bounds.width }
	var screenH: CGFloat { UIScreen.main.bounds.height }
	var isValid: Bool {
		for textField in textFieldsay { if !textField.isValid { return false }}
		return true
	}
//	var cardInfo: IOTCardInfo { IOTCardInfo(cardNumber: cardNumberTextField.valueString,
//																					holderName: holderNameTextField.valueString,
//																					expiryDate: expiryDateTextField.valueString,
//																					cvv: cvvTextField.valueString)}

	// temp? var
	private var textFieldsay: [IOTDeformableTextField] = []

	// MARK: life cycle
	init(action: IOTNetworkRequestAction, layout: IOTCardInfoViewLayout) {
		self.action = action
		self.layout = layout
		self.viewModel = IOTCardInfoViewModel()
		super.init(frame: CGRect.zero)
		commonInit()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

//	required init?(coder: NSCoder) {
//		self.viewModel = IOTCardInfoViewModel()
//		super.init(frame: CGRect.zero)
//		commonInit()
//	}

	func commonInit() {
		viewModel.delegate = self
		//textFieldsay = [holderNameTextField, cardNumberTextField, expiryDateTextField, cvvTextField]
		//viewModel.start()
		//viewModel.delegate = self
		//setupSelf()
		//setupSegments()
		//setupViewEach()

		setupView()

		layer.masksToBounds = true
		//selectedTextField = nil
		//toTextFieldComposition(fromComposition: .normal, toComposition: .normal)
	}

	deinit {}


	private func setupView() {
//		if layout.isDisplayingCardIcon {
//			cardIconView = IOTCardIconView()
//			addSubview(cardIconView!)
//		}
//		addSubview(holderNameTextField)
//		addSubview(cardNumberTextField)
//		addSubview(expiryDateTextField)
//		addSubview(cvvTextField)
	}

	private func setupUserInputTarget() {
//		holderNameTextField.addTarget(self, action: #selector(onTextFieldDidSelect(sender:)), for: .editingDidBegin)
//		cardNumberTextField.addTarget(self, action: #selector(onTextFieldDidSelect(sender:)), for: .editingDidBegin)
//		expiryDateTextField.addTarget(self, action: #selector(onTextFieldDidSelect(sender:)), for: .editingDidBegin)
//		cvvTextField.addTarget(self, action: #selector(onTextFieldDidSelect(sender:)), for: .editingDidBegin)
//
//		holderNameTextField.addTarget(self, action: #selector(onTextFieldDidChange(sender:)), for: .editingChanged)
//		cardNumberTextField.addTarget(self, action: #selector(onTextFieldDidChange(sender:)), for: .editingChanged)
//		expiryDateTextField.addTarget(self, action: #selector(onTextFieldDidChange(sender:)), for: .editingChanged)
//		cvvTextField.addTarget(self, action: #selector(onTextFieldDidChange(sender:)), for: .editingChanged)

//		textFieldsay.forEach {
//			$0.addTarget(viewModel, action: #selector(viewModel.onTextFieldDidSelect(sender:)), for: .editingDidBegin)
//			$0.addTarget(viewModel, action: #selector(viewModel.onTextFieldDidChange(sender:)), for: .editingChanged)
//		}

	}







}



extension IOTCardInfoView: IOTCardInfoViewModelDelegate {
	func updatingComposition(fromSelection: IOTTextFieldSubject, toSeletion: IOTTextFieldSubject, aimation: Bool) {

	}

	func updatingImageIcon(to state: IOTCardIconState) {
		
	}

//	func onRelocatingUpdate(fromComposition: TextFieldComposition, toComposition: TextFieldComposition, aimation: Bool) {
//
//	}
//
////	delegate
//
//	func toTextFieldComposition(fromComposition: TextFieldComposition, toComposition: TextFieldComposition) {
////		let segmentRectArr = segmentRectArray(composition: toComposition)
////		cardIconView.frame = segmentRectArr[0]
////		nameTextField?.frame = segmentRectArr[1]
////		numberTextField.frame = segmentRectArr[2]
////		expiryDateTextField.frame = segmentRectArr[3]
////		cvvTextField.frame = segmentRectArr[4]
//	}
//
//	func animatToTextFieldComposition(fromComposition: TextFieldComposition, toComposition: TextFieldComposition) {
////		print("from to", fromComposition, toComposition)
////		textFieldComposition(composition: fromComposition)
////		UIView.animate(withDuration: defaultTextFieldRelocationAnimationTimeInterval) { [weak self] in
////			self?.textFieldComposition(composition: toComposition)
////		} completion: { (completed) in
////			if completed {
////				print("animation done")
////			}
////		}
//
//	}
//
//	private func textFieldComposition(composition: TextFieldComposition) {
////		let segmentRectArr = segmentRectArray(composition: composition)
////		//cardIconView.frame = segmentRectArr[0]
////		nameTextField?.frame = segmentRectArr[1]
////		numberTextField.frame = segmentRectArr[2]
////		expiryDateTextField.frame = segmentRectArr[3]
////		cvvTextField.frame = segmentRectArr[4]
//	}

}







enum SingleLineWidthRatios {
	case normal
	case fullHolderName
	case fullCardNumber

	var segmentRatioArr: [CGFloat] {
		switch self {
		case .normal: return [0.1, 0.3, 0.2, 0.2, 0.2]
		case .fullHolderName: return [0.1, 0.7, 0.2, 0.2, 0.2]
		case .fullCardNumber: return [0.1, 0.2, 0.5, 0.2, 0.2]
		}
	}

	func ratioArr(at state: IOTTextFieldSubject?) -> [CGFloat] {
		switch state {
		case .holderName: return self.segmentRatioArr
		case .cardNumber: return [0.1, 0.2, 0.5, 0.2, 0.2]
		default: return [0.1, 0.3, 0.2, 0.2, 0.2]
		}
	}
}





//enum TextFieldComposition {
//	case normal
//	case fullHolderName
//	case fullCardNumber
//
//	var segmentRatioArr: [CGFloat] {
//		switch self {
//		case .normal: return [0.1, 0.3, 0.2, 0.2, 0.2]
//		case .fullHolderName: return [0.1, 0.7, 0.2, 0.2, 0.2]
//		case .fullCardNumber: return [0.1, 0.2, 0.5, 0.2, 0.2]
//		}
//	}
//
//	var segmentRatioArrSum: CGFloat {
//		switch self {
//		case .normal: return segmentRatioArr.reduce(0, +)
//		case .fullHolderName: return segmentRatioArr.reduce(0, +)
//		case .fullCardNumber: return segmentRatioArr.reduce(0, +)
//		}
//	}

//		var widthMultiplier: CGFloat {
//			switch self {
//			case .normal: break //return segmentRectArray.reduce(0, { $0.portion(textFieldComposition: self) + $1.portion(textFieldComposition: self)})
//			case .fullHolderName: return 2.0
//			case .fullCardNumber: return 2.0
//			}
//		}
//
//		var sumOfPortion: CGFloat {
//			segmentRectArray.reduce(0, { $0.portion(textFieldComposition: self) + $1.portion(textFieldComposition: self)})
//		}
//}
