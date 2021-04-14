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

final class IOTCardInfoComponentsFacade {

	var viewComponents: IOTCardInfoComponents

	init(action: IOTNetworkRequestAction, layout: IOTCardInfoViewLayout, style: IOTCardInfoViewStyle){
		viewComponents = IOTCardInfoComponents(action: action, layout: layout, style: style)
	}

	func setCardView(frame: CGRect) {
		viewComponents.setCardView(frame: frame)
	}

	func setSegmentModel(config: IOTSegmentModel.IOTSegmentModelConfig) {
		viewComponents.setSegmentModel(config: config)
	}

	func setTextFieldsView(frame: CGRect) {
		viewComponents.frame = frame
	}

	func layoutSubview() {
		viewComponents.updateLayout()
		//print(viewComponents.)
	}


}
