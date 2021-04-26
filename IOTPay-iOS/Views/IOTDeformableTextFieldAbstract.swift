//
//  IOTDeformableTextFieldAbstract.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

class IOTDeformableTextField: IOTTextField {
//
//	var thumbnailPlaceholder: String { subject.thumbnailPlaceholder }
//	var displayState: DisplayState = .thumbnail { didSet { placeholder = displayState == .full ? normalPlaceholder : thumbnailPlaceholder }}
//


	//init(cardTextFieldLayout: CardTextFieldLayout, textFieldType: TextFieldType) {
//	override init(textFieldType: IOTTextFieldSubject) {
//		//self.cardTextFieldLayout = cardTextFieldLayout
//		//isDeformable = true
//		self.attribute = .de
//		super.init(textFieldType: textFieldType)
//		commonInit()
//
//	}




}


//
//protocol ViewModelForDeformable {
//	var thumbnailPlaceholder: String { get }
//	var displayState: IOTTextFieldDisplayState { get set }
//}
//
//class IOTDeformableTextFieldViewModel: IOTTextFieldViewModel, ViewModelForDeformable {
//
//	var thumbnailPlaceholder: String { subject.thumbnailPlaceholder }
//	var attributedthumbnailPlaceholder: NSAttributedString {
//		attributedString(text: thumbnailPlaceholder, with: IOTColor.placeholderTextColor)
//	}
//	var displayState: IOTTextFieldDisplayState = .thumbnail {
//		didSet {
//			displayState == .full ?
//				delegate?.updatePlaceholder(attributedPlaceholder: attributedPlaceholder) : delegate?.updatePlaceholder(attributedPlaceholder: attributedthumbnailPlaceholder)
//			//delegate?.updateTextField(text: placeholder, with: nil)
//		}
//	}
//
//	//override var placeholder: String { return "override" }
//
//
//
//	//init(cardTextFieldLayout: CardTextFieldLayout, textFieldType: TextFieldType) {
////	override init(textFieldType: IOTTextFieldSubject) {
////		//self.cardTextFieldLayout = cardTextFieldLayout
////		//isDeformable = true
////		self.attribute = .de
////		super.init(textFieldType: textFieldType)
////		commonInit()
////
////	}
//
//
//
//
//}
//
////extension IOTDeformableTextFieldViewModel {
////	enum DisplayState {
////		case thumbnail
////		case full
////	}
////}
//
