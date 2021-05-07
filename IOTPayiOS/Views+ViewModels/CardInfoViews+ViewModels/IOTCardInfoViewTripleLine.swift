//
//  IOTCardInfoViewTripleLine.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import UIKit

@objc
public final class IOTCardInfoViewTripleLineOnCardView: IOTDeformableCardInfoView {

	private let defaultLabelHeight: CGFloat = 40.0
	//private let defaultLabelHorizontalSpacePortionToScreenWidth: CGFloat = 0.1
	//private let defaultVerticalMargin: CGFloat = 10.0
	private let defaultLabelWidthPortionToScreenWidth: CGFloat = 0.9
	//private let defaultCardHeightToLabelHeight: CGFloat = 0.5
	//private let defaultCardLeftMarginToWidth: CGFloat = 0.015
	//private let defaultTextFieldRelocationAnimationTimeInterval: TimeInterval = 0.3


	private let cardWidthHeightRatio: CGFloat = 1.586
	private let labelHeightToLabelGroupHeightRatio: CGFloat = 0.41
	private let cardViewNLabelGroupSpaceHeightTOSelfHeightRatio: CGFloat = 0.03

	public override var frame: CGRect { didSet { updateLayout() }}

	private var deformConfig = IOTDeformConfig(
		initDisplayState: [.full, .full, .full, .full],
		nilSeletionRatios: [1.0, 1.0, 0.4, 0.4],
		fixedRects: []
	)

	@objc
	public init(action: IOTNetworkRequestAction, style: IOTCardInfoViewStyle) {
		let layout: IOTCardInfoViewLayout = .tripleLineOnLargeCardView
		super.init(action: action, layout: layout, style: style, deformConfig: deformConfig)
		defaultLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func defaultLayout() {
		let width = defaultLabelWidthPortionToScreenWidth * screenW
		let height = defaultLabelHeight
		frame.size = CGSize(width: width, height: height)
		layer.cornerRadius = 5;
		frame = CGRect(x: 0, y: 0, width: screenW, height: screenW / cardWidthHeightRatio)
		backgroundColor = IOTColor.system5.uiColor
		addSubview(facade.viewComponents)
	}

	func updateLayout() {
		let cardViewWidthToScreenWidth: CGFloat = 0.95
		let cardViewWidth = screenW * cardViewWidthToScreenWidth
		let cardViewHeight = cardViewWidth / cardWidthHeightRatio
		let cardOrigin = CGPoint(x: (frame.width - cardViewWidth) * 0.5, y: 0)
		let cardRect = CGRect(origin: cardOrigin,
													size: CGSize(width: cardViewWidth, height: cardViewHeight))

		let textFieldVertialSpace = (1.0 - labelHeightToLabelGroupHeightRatio * 3) / 2
		//let topEmptySpacerRatio = 0.1
		let textlRectNSpaceArr = DYSegmenter.vertical(
			rect: cardRect,
			ratios: [labelHeightToLabelGroupHeightRatio, textFieldVertialSpace,
							 labelHeightToLabelGroupHeightRatio, textFieldVertialSpace,
							 labelHeightToLabelGroupHeightRatio],
			spaceRatio: cardViewNLabelGroupSpaceHeightTOSelfHeightRatio,
			edgeRatio: DYSegmenter.EdgeRatio(left: 0.05, right: 0.05, top: 0.42, bottom: 0.1)
		)
		let topRect = textlRectNSpaceArr[0]
		let midRect = textlRectNSpaceArr[2]
		let botRect = textlRectNSpaceArr[4]

		let bottomThree = DYSegmenter.horizontal(
			rect: botRect,
			ratios: [0.35, 0.3, 0.35],
			spaceRatio: cardViewNLabelGroupSpaceHeightTOSelfHeightRatio
		)

		let parentFrame = CGRect(origin: CGPoint.zero, size: frame.size)

		let viewRectsArr = [topRect, midRect, bottomThree[0], bottomThree[2],
												cardRect, parentFrame,]

		facade.setFixedViewRects(array: viewRectsArr)
		facade.layoutSubview()
	}
}
