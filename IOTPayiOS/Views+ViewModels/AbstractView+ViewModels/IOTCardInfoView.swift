//
//  IOTCardInfoView.swift
//  IOTPayUIPlayground
//
//  Created by macbook on 2021-04-05.
//

import UIKit

@objc
public protocol IOTCardInfoViewDelegate: AnyObject {
	func onDidCompleteValidate()
}

public class IOTCardInfoView: UIView {

	@objc
	public var delegate: IOTCardInfoViewDelegate?

	let facade: IOTCardInfoComponentsFacade
	//MARK: Constants
	// init constants
	var action: IOTNetworkRequestAction
	let layout: IOTCardInfoViewLayout
	let style: IOTCardInfoViewStyle
	// default constatns

	// models
	let viewModel: IOTCardInfoViewModel

	// calculated var
	var screenW: CGFloat { UIScreen.main.bounds.width }
	var screenH: CGFloat { UIScreen.main.bounds.height }
	var isValid: Bool {
		for textField in textFieldsay { if !textField.isValid { return false }}
		return true
	}

	// temp var
	private var textFieldsay: [IOTDeformableTextField] = []

	// MARK: life cycle
	public init(action: IOTNetworkRequestAction, layout: IOTCardInfoViewLayout, style: IOTCardInfoViewStyle) {
		self.action = action
		self.layout = layout
		self.style = style
		self.facade = IOTCardInfoComponentsFacade(action: action, layout: layout, style: style)
		self.viewModel = IOTCardInfoViewModel()
		super.init(frame: CGRect.zero)
		commonInit()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func commonInit() {
		setupDismissKeyboardCondition()
		backgroundColor = IOTColor.labelBackground.uiColor
		viewModel.delegate = self
		facade.delegate = self


		setupView()

		layer.masksToBounds = true
	}

	deinit {}

	private func setupDismissKeyboardCondition() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(onHideKeyboard))
		addGestureRecognizer(tap)
	}

	@objc func onHideKeyboard() {
		endEditing(true)
	}

	private func setupView() { }


	private func setupUserInputTarget() { }

}

extension IOTCardInfoView: IOTCardInfoComponentsFacadeDelegate {
	func onDidCompleteValidate() {
		delegate?.onDidCompleteValidate()
	}
}


extension IOTCardInfoView: IOTCardInfoViewModelDelegate {
	func updatingComposition(fromSelection: IOTTextFieldSubject, toSeletion: IOTTextFieldSubject, aimation: Bool) { }

	func updatingImageIcon(to state: IOTCardIconState) { }
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

