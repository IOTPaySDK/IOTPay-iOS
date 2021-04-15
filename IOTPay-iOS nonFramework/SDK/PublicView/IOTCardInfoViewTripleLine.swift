//
//  IOTCardInfoViewTripleLine.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import UIKit

final class IOTCardInfoViewTripleLine: IOTCardInfoView {

	//var composition: IOTTextFieldCompostition
	let style: Style

	private let defaultLabelHeight: CGFloat = 40.0
	private let defaultLabelHorizontalSpacePortionToScreenWidth: CGFloat = 0.1
	private let defaultVerticalMargin: CGFloat = 10.0
	private let defaultLabelWidthPortionToScreenWidth: CGFloat = 0.9
	private let defaultCardHeightToLabelHeight: CGFloat = 0.5
	private let defaultCardLeftMarginToWidth: CGFloat = 0.015
	private let defaultTextFieldRelocationAnimationTimeInterval: TimeInterval = 0.3
	private let viewWidthRatios = IOTDeformConfig(
		initDisplayState: [.full, .full, .full, .full,],
		nilSeletionRatios: [0.1, 0.3, 0.2, 0.2, 0.2],
		cardNumberRatios: [0.1, 0.7, 0.2, 0.2, 0.2],
		holderNameRatios: [0.1, 0.2, 0.5, 0.2, 0.2]
	)

//	override init(layout: IOTCardInfoViewLayout, action: IOTNetworkRequestAction) {
//		super.init(layout: layout, action: action)
//	}


	init(action: IOTNetworkRequestAction, style: Style? = nil) {
		self.style = style ?? .roundRect
		super.init(action: action, layout: .tripleLine)
		
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func defaultLayout() {
		let width = defaultLabelWidthPortionToScreenWidth * screenW
		let height = defaultLabelHeight
		frame.size = CGSize(width: width, height: height)
		layer.cornerRadius = 5;
		backgroundColor = IOTColor.system5.uiColor
	}


}

extension IOTCardInfoViewTripleLine {
	enum Style {
		case roundRect
		case infoLight
		case infoDark
	}
}
