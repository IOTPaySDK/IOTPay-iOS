//
//  IOTCardInfoComponents.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import UIKit

//protocol IOTCardInfoComponentsProtocol {
//	IOTCardInfoComponents
//}

protocol IOTCardInfoComponentsTransportDelegate: IOTNetworkService //IOTPay_iOS_nonFramework.//IOTNetworkManager
{
	func transport(action: IOTNetworkRequestAction, info: IOTCardInfo)
}

protocol IOTCardInfoComponentsDelegate: AnyObject {
//	func updateCardIconView(displayState: IOTCardIconState)
//	func updateCardIconView(temporaryEvent: IOTCardIconTemporaryEvent)
//	func updateTextFieldSeletedIndex(subject: Int)
	func onDidCompleteValidate()
}


public final class IOTCardInfoComponents: UIView {

	weak var transportDelegate: IOTCardInfoComponentsTransportDelegate?
	weak var componentsDelegate: IOTCardInfoComponentsDelegate?

	private let viewModel: IOTCardInfoComponentsViewModel

	private let textFields: [IOTTextField]
	private let cardIconView: IOTCardIconView?
	private var cardLargeView: IOTCardView?

	private let action: IOTNetworkRequestAction

	//private let layout: IOTCardInfoViewLayout

	//var seletedTextFieldIndex: Int? { viewModel.seletedTextFieldIndex }

	private var patternPrediction: IOTCardPatternPrediction = .unrecognized {
		didSet {
			if oldValue != patternPrediction {
				textFields.forEach { $0.patternPrediction = patternPrediction }
				if cardIconView?.state != nil {
					cardIconView?.state = patternPrediction.cardIconDisplayState
				}
				if let cardLargeView = cardLargeView,
					 viewModel.layout == .tripleLineWithLargeCardViewOnTop {
					cardLargeView.playCycleAnimation(till: patternPrediction.cardCulingCycle)
				}
			}
		}
	}

	//var cardInfo: IOTCardInfo { IOTCardInfo.init(viewComponents: self) }

	private var isValid: Bool { textFields.allSatisfy { $0.isValid }}


	init(action: IOTNetworkRequestAction, layout: IOTCardInfoViewLayout, style: IOTCardInfoViewStyle) {

		self.action = action
		viewModel = IOTCardInfoComponentsViewModel()


		let textFieldFactory = IOTTextFieldFactory()
		textFields = textFieldFactory.makeTextFieldArray(subjectSequence: nil,
																										 attributeSequence: [layout.textFieldAttribute])
		cardIconView = layout.isDisplayingCardIcon ? IOTCardIconView() : nil

		super.init(frame: CGRect.zero)

		viewModel.viewModeDelegate = self
		viewModel.layout = layout
		commonInit(layout: layout)



	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func commonInit(layout: IOTCardInfoViewLayout) {
		textFields.forEach {
			addSubview($0)
			$0.addTarget(viewModel, action: #selector(viewModel.onTextFieldDidSelect(sender:)), for: .editingDidBegin)
			$0.addTarget($0.viewModel, action: #selector($0.viewModel.onTextFieldDidChange(sender:)), for: .editingChanged)
		}
		for textField in textFields { textField.textFieldDelegate = viewModel }

		if layout.isDisplayingCardIcon { addSubview(cardIconView!) }

		clipsToBounds = true




	}


//	func textField(subject: IOTTextFieldSubject) -> IOTTextField {
//		textFields.first { $0.subject == subject }!
//	}

//	func onTextFieldValidCompletion(textField: IOTTextField) {
//		focusedOn(textField: )
//	}

//	private func focusedOn(textField: IOTTextField) {
//
//	}

	deinit {}


}

//MARK: Connection with facade
extension IOTCardInfoComponents {
	func setSegmentModel(config: IOTSegmentModel.IOTSegmentModelConfig) {
		viewModel.setupDefromableCapability(segmentModelConfig: config)
	}

	func setIOTCardView(frame: CGRect) {
		cardIconView?.frame = frame
		cardIconView?.updateFrame()
	}

	func updateLayout() {
		//viewModel.segmentModel
	}
}


extension IOTCardInfoComponents: IOTCardInfoComponentsViewModelDelegate {
	func onDidFinishCardInfoValidate() {
		for textField in textFields where textField.subject == .holderName  {
			
		}
		//textFields.forEach // where  { $0.resignFirstResponder() }
		componentsDelegate?.onDidCompleteValidate()
	}

	func updatePatternPrediction(to patternPrediction: IOTCardPatternPrediction) {
		self.patternPrediction = patternPrediction
	}


	func updateFirstResponder(to textFieldAtIndex: Int) {
		textFields[textFieldAtIndex].becomeFirstResponder()
	}


	func playCardFlipAnimation(to: IOTCardSide) {
		if cardIconView != nil && viewModel.layout == .singleLineWithSmallCardIcon {
			if to == .back {
				cardIconView?.state = .back
			} else {
				cardIconView?.state = patternPrediction.cardIconDisplayState
			}
		}

		if let cardLargeView = cardLargeView, viewModel.layout == .tripleLineWithLargeCardViewOnTop {
			if to == .back && cardLargeView.side == .front {
				cardLargeView.playFlipAnimation()
			} else if to == .front && cardLargeView.side == .back {
				cardLargeView.playFlipAnimation()
			}
		}
	}

	func playTextFieldAnimation(fromPositions: [CGRect], toPosition: [CGRect]) {
		for i in 0..<textFields.count { textFields[i].frame = fromPositions[i] }
		UIView.animate(withDuration: 0.2) { [weak self] in
			guard let self = self else { return }
			for i in 0..<self.textFields.count { self.textFields[i].frame = toPosition[i] }
		} completion: { (completed) in
			if completed {}
		}

	}

	func onDidUpdateCardIconViewLayout(rect: CGRect) { }

	func onDidUpdateTextFieldsLayout(rectArray: [CGRect]) {
		for i in 0..<textFields.count { textFields[i].frame = rectArray[i] }
	}

	func onDidLoad(initDisplayState: [IOTTextFieldDisplayState]) {
		for i in 0..<textFields.count { textFields[i].displayState = initDisplayState[i] }
	}
}




//MARK: Animation
extension IOTCardInfoComponents {
	func playTextFieldAnimation(fromPositions: [CGPoint], toPositions: [CGPoint],
															duration: TimeInterval) {

		for i in 0..<textFields.count { textFields[i].frame.origin = fromPositions[i] }
		UIView.animate(withDuration: 0.5) { [weak self] in
			guard self?.textFields.count != nil else { return }
			if let count = self?.textFields.count {
				for i in 0..<count { self?.textFields[i].frame.origin = toPositions[i] }
			}
		}
	}
}

extension IOTCardInfoComponents {
	func transport() {
		let info = IOTCardInfo(
			cardNumber: textFields[IOTTextFieldSubject.cardNumber.rawValue].valueString!,
			holderName: textFields[IOTTextFieldSubject.holderName.rawValue].valueString!,
			expiryDate: textFields[IOTTextFieldSubject.expiryDate.rawValue].valueString!,
			cvv: textFields[IOTTextFieldSubject.cvv.rawValue].valueString!)
		transportDelegate?.transport(action: action, info: info)
	}
}

//Fixed size layout setting
extension IOTCardInfoComponents {

	func setFixedViewRects(array: [CGRect]) {
		cardLargeView = IOTCardView(frame: array[4])
		addSubview(cardLargeView!)
		frame = array[5]
		setupStyle(array: array)
	}

	private func setupStyle(array: [CGRect]) {
		if viewModel.layout == .tripleLineWithLargeCardViewOnTop {
			for i in 0..<textFields.count {
				let backRectView = UIView(frame: array[i])
				backRectView.layer.cornerRadius = 10.0
				backRectView.layer.borderWidth = 1.0
				backRectView.layer.borderColor = IOTColor.roundRectBoderColorBlue.uiColor.cgColor
				backRectView.backgroundColor = IOTColor.labelBackground.uiColor
				backRectView.alpha = 0.8
				backRectView.isUserInteractionEnabled = false
				addSubview(backRectView)

				let leftSpace = array[0].width * 0.05
				let textFieldsWidth = array[i].width - leftSpace * 2.0
				textFields[i].frame = CGRect(
					x: array[i].origin.x + leftSpace, y: array[i].origin.y,
					width: textFieldsWidth, height: array[i].size.height)
				addSubview(textFields[i])

				textFields[i].font = UIFont.systemFont(ofSize: 17)
			}
			onDidLoad(initDisplayState: [.full, .full, .full, .full])
		}
	}
}

