//
//  IOTCardInfoComponentsViewModel.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import UIKit


protocol IOTCardInfoComponentsViewModelDelegate: AnyObject {
//	func updatingComposition(fromSelection: IOTTextFieldSubject, toSeletion: IOTTextFieldSubject, aimation: Bool)
//	func updatingImageIcon(to state: IOTCardIconState)
	func onDidLoad(initDisplayState: [IOTTextFieldDisplayState])
	func onDidUpdateTextFieldsLayout(rectArray: [CGRect])
	func onDidUpdateCardIconViewLayout(rect: CGRect)
	func onDidFinishCardInfoValidately()

	func updateFirstResponder(to textFieldAtIndex: Int)
	func updatePatternPrediction(to patternPrediction: IOTCardPatternPrediction)


	func playTextFieldAnimation(fromPositions: [CGRect], toPosition: [CGRect])
	func playCardFlipAnimation(to: IOTCardSide)

}

final class IOTCardInfoComponentsViewModel: NSObject, UITextFieldDelegate {

	weak var viewModeDelegate: IOTCardInfoComponentsViewModelDelegate?

	var layout: IOTCardInfoViewLayout!

	private var textFieldAnimationModel: IOTTextFieldAnimationModel?
	private var cardAnimationModel: IOTCardAnimationModel?
	private var segmentModel: IOTSegmentModel?
	
	var cardPatternPrediction: IOTCardPatternPrediction?

	var seletedTextFieldSubject: IOTTextFieldSubject? {
		willSet {
			if layout.isTextFieldAnimating {
				startTextFieldAnimation(fromSubject: seletedTextFieldSubject, toSubject: newValue)
			}
			if seletedTextFieldSubject == .cvv || newValue == .cvv {
				startCardFlipAnimation(toSubject: newValue)
			}
		}
	}

	var completionArray: [Bool] = [false, false, false, false]

	var seletedTextFieldIndex: Int? { seletedTextFieldSubject?.rawValue }

	var nextTextFieldIndex: Int? {
//		if let index = seletedTextFieldSubject?.rawValue {
//			return index < IOTTextFieldSubject.allCases.count - 1 ? index + 1 : nil
//		}
		guard let index = seletedTextFieldSubject?.rawValue else { return nil }
		return index < IOTTextFieldSubject.allCases.count - 1 ? index + 1 : nil
	}

	override init() {
		super.init()

	}



	//Deform var
	//var segmentModelConfig: IOTSegmentModel.IOTSegmentModelConfig!
//	var segmentModel: IOTSegmentModel!

	@objc func onTextFieldDidSelect(sender: IOTTextField) { // first responser
		seletedTextFieldSubject = sender.subject
	}

	@objc func onTextFieldDidChange(sender: IOTTextField) { // first responser

	}
}


//MARK: Defromable layout
extension IOTCardInfoComponentsViewModel {
	func setupDefromableCapability(segmentModelConfig: IOTSegmentModel.IOTSegmentModelConfig) {
		segmentModel = IOTSegmentModel()
		segmentModel!.config = segmentModelConfig
		let rectArray = segmentModel!.rectArr(for: .none)
		viewModeDelegate?.onDidUpdateTextFieldsLayout(rectArray: rectArray)
		viewModeDelegate?.onDidLoad(initDisplayState: segmentModelConfig.deformConfig.initDisplayState)

		textFieldAnimationModel = IOTTextFieldAnimationModel()
	}

	func startTextFieldAnimation(fromSubject: IOTTextFieldSubject?, toSubject: IOTTextFieldSubject?) {
		let fromRects = segmentModel!.rectArr(for: fromSubject)
		let toRects = segmentModel!.rectArr(for: toSubject)
		viewModeDelegate?.playTextFieldAnimation(fromPositions: fromRects, toPosition:toRects)
	}

	func startCardFlipAnimation(toSubject: IOTTextFieldSubject?) {
		let side: IOTCardSide = toSubject == .cvv ? .back : .front
		viewModeDelegate?.playCardFlipAnimation(to: side)
	}

}


extension IOTCardInfoComponentsViewModel: IOTTextFieldDelegate {
	func onDidPredicate(cardPattern: IOTCardPatternPrediction) {
		viewModeDelegate?.updatePatternPrediction(to: cardPattern)
	}

	func onDidSelected(textField: IOTTextFieldSubject) {

	}

	func onDidChanged(textField: IOTTextFieldSubject, text: String) {

	}

	func onDidComplete(textField: IOTTextFieldSubject, isValid: Bool) {
		completionArray[textField.rawValue] = isValid
		print("onDidComplete", completionArray)
		if completionArray == [true, true, true, true] {
			viewModeDelegate?.onDidFinishCardInfoValidately()
			return
		}

		if let nextTextFieldIndex = nextTextFieldIndex, seletedTextFieldSubject == textField {
			if textField.isPassingFirstResponderToNext {
				viewModeDelegate?.updateFirstResponder(to: nextTextFieldIndex)
			}
		}
	}
}



