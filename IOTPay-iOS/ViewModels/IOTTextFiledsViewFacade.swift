//
//  IOTTextFiledsFacade.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-13.
//

import UIKit

protocol IOTCardInfoComponentsFacadeDelegate {
	func cardInfoDidValidate()
}


final class IOTCardInfoComponentsFacade: NSObject {

	var viewComponents: IOTCardInfoComponents

	init(action: IOTNetworkRequestAction, layout: IOTCardInfoViewLayout, style: IOTCardInfoViewStyle){
		viewComponents = IOTCardInfoComponents(action: action, layout: layout, style: style)
	}

	func setIOTCardView(frame: CGRect) {
		viewComponents.setIOTCardView(frame: frame)
	}

	func setSegmentModel(config: IOTSegmentModel.IOTSegmentModelConfig) {
		viewComponents.setSegmentModel(config: config)
	}

	func setTextFieldsView(frame: CGRect) {
		viewComponents.frame = frame
	}

//	func setLargeCard(width: CGFloat) {
//		viewComponents.setLargeCard(width: width)
//	}

	func setFixedViewRects(array: [CGRect]) {
		viewComponents.setFixedViewRects(array: array)
	}

	func layoutSubview() {
		viewComponents.updateLayout()
	}


}
