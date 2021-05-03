//
//  IOTCardInfoViewSingleLineNCardIconWithLargeIcon.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-14.
//


import UIKit

public class IOTCardInfoViewTripleLineNCardView: IOTDeformableCardInfoView {

	private let defaultLabelHeight: CGFloat = 50.0
	private let defaultVerticalMargin: CGFloat = 10.0
	private let defaultLabelWidthPortionToScreenWidth: CGFloat = 0.9
	private let defaultCardHeightToLabelHeight: CGFloat = 0.5
	private let defaultCardLeftMarginToWidth: CGFloat = 0.015
	private let defaultTextFieldRelocationAnimationTimeInterval: TimeInterval = 0.3
	private let defaultCardAndTextFieldHorzontalEdgeToParentWidth: CGFloat = 0.02
	private let defaultCardTextFieldHorzontalSpaceToParentWidth: CGFloat = 0.01
	private let defalutCardLargeViewWidthToScreenWidth: CGFloat = 0.8
	private let cardWidthHeightRatio: CGFloat = 1.586

	private let minLabelHeight: CGFloat = 30.0
	private let maxLabelHeight: CGFloat = 60.0
	private let verticalEdgeToSelfHeightRatio: CGFloat = 0.01
	private let horzontalEdgeToSelfWidthRatio: CGFloat = 0.015
	private let cardViewHeigtRatioToAfterEdgeAndSpaceHeigt: CGFloat = 0.6
	private let labelHeightToLabelGroupHeightRatio: CGFloat = 0.3
	private let cardViewNLabelGroupSpaceHeightTOSelfHeightRatio: CGFloat = 0.03
	private let cardViewHorzontalEdgeToSelfWidthRatio: CGFloat = 0.1
	private let labelToLabelHorzontalSpaceToGroupRatio: CGFloat = 0.01

	private var deformConfig = IOTDeformConfig(
		initDisplayState: [.full, .full, .full, .full],
		nilSeletionRatios: [1.0, 1.0, 0.4, 0.4],
		fixedRects: []
	)

	convenience public init(action: IOTNetworkRequestAction, style: IOTCardInfoViewStyle?) {
		let style = style ?? .autoDarkModeSupport
		self.init(action: action, style: style)
	}

	@objc
	public init(action: IOTNetworkRequestAction, style: IOTCardInfoViewStyle) {
		let layout: IOTCardInfoViewLayout = .tripleLineWithLargeCardViewOnTop
		super.init(action: action, layout: layout, style: style, deformConfig: deformConfig)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func commonInit() {
		super.commonInit()
		defaultLayout()
	}

	private func defaultLayout() {
		frame = CGRect(x: 0, y: 0, width: screenW, height: screenH * 0.5)
		backgroundColor = IOTColor.system5.uiColor
	}

	public override var frame: CGRect { didSet { updateLayout() }}

	func updateLayout() {

		subviews.forEach { $0.removeFromSuperview() }


		let (cardViewRect, textFieldsRect) = DYSegmenter.verticalTwo(
			rect: CGRect(origin: CGPoint.zero, size: frame.size),
			ratios: [cardViewHeigtRatioToAfterEdgeAndSpaceHeigt,
							 1.0 - cardViewHeigtRatioToAfterEdgeAndSpaceHeigt],
			spaceRatio: cardViewNLabelGroupSpaceHeightTOSelfHeightRatio,
			edgeRatio: DYSegmenter.EdgeRatio(
				horizontal: horzontalEdgeToSelfWidthRatio, vertical: verticalEdgeToSelfHeightRatio
			)
		)

		let cardViewSize: CGSize
		let cardViewRectRatio = cardViewRect.width / cardViewRect.height
		if cardViewRectRatio <= cardWidthHeightRatio {
			let width = cardViewRect.width
			cardViewSize = CGSize(width: width, height: width / cardWidthHeightRatio)
		} else {
			let height = cardViewRect.height
			cardViewSize = CGSize(width: height * cardWidthHeightRatio, height: height)
		}

		let cardAspectRect = CGRect(x: (frame.width - cardViewSize.width) * 0.5,
																y: (verticalEdgeToSelfHeightRatio * frame.height),
																width: cardViewSize.width, height: cardViewSize.height)

		let textFieldVertialSpace = (1.0 - labelHeightToLabelGroupHeightRatio * 3) / 2
		let textlRectNSpaceArr = DYSegmenter.vertical(
			rect: textFieldsRect,
			ratios: [labelHeightToLabelGroupHeightRatio, textFieldVertialSpace,
							 labelHeightToLabelGroupHeightRatio, textFieldVertialSpace,
							 labelHeightToLabelGroupHeightRatio],
			spaceRatio: cardViewNLabelGroupSpaceHeightTOSelfHeightRatio
		)
		let topRect = textlRectNSpaceArr[0]
		let midRect = textlRectNSpaceArr[2]
		let botRect = textlRectNSpaceArr[4]


		let bottomThree = DYSegmenter.horizontal(
			rect: botRect,
			ratios: [0.45, 0.1, 0.45],
			spaceRatio: cardViewNLabelGroupSpaceHeightTOSelfHeightRatio
		)

		let parentFrame = CGRect(origin: CGPoint.zero, size: frame.size)

		let viewRectsArr = [topRect, midRect, bottomThree[0], bottomThree[2],
												cardAspectRect, parentFrame,]

		facade.setFixedViewRects(array: viewRectsArr)
		facade.layoutSubview()
		addSubview(facade.viewComponents)

	}

}

