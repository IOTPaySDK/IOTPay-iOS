//
//  IOTCardInfoViewSingleLineNCardIcon.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//




//enum IOTTextFieldCompostition {
//	case normal
//}

import UIKit

public class IOTCardInfoViewSingleLineNCardIcon: IOTDeformableCardInfoView {

	private let defaultLabelHeight: CGFloat = 50.0
	private let defaultVerticalMargin: CGFloat = 10.0
	private let defaultLabelWidthPortionToScreenWidth: CGFloat = 0.9
	private let defaultCardHeightToLabelHeight: CGFloat = 0.5
	private let defaultCardLeftMarginToWidth: CGFloat = 0.015
	private let defaultTextFieldRelocationAnimationTimeInterval: TimeInterval = 0.3
	private let defaultCardAndTextFieldHorzontalEdgeToParentWidth: CGFloat = 0.02
	private let defaultCardTextFieldHorzontalSpaceToParentWidth: CGFloat = 0.01
	private let deformConfig = IOTDeformConfig(
		initDisplayState: [.thumbnail, .thumbnail, .thumbnail, .thumbnail],
		nilSeletionRatios: [0.3, 0.3, 0.23, 0.17],
		cardNumberRatios: [0.6, 0.3, 0.23, 0.17],
		holderNameRatios: [0.3, 0.6, 0.23, 0.17]
	)

	//@objc
	public override var frame: CGRect { didSet { updateLayout() }}


	@objc
	public init(action: IOTNetworkRequestAction, style: IOTCardInfoViewStyle) {
		super.init(action: action,
							 layout: .singleLineWithSmallCardIcon,
							 style: style,
							 deformConfig: deformConfig)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func commonInit() {
		defaultLayout()
		super.commonInit()
	}

	private func defaultLayout() {
		frame = CGRect(x: 0, y: 0, width: screenW, height: defaultLabelHeight)
		backgroundColor = IOTColor.system5.uiColor(for: style)
	}

	func updateLayout() {
		let labelGridWidthHeight = defaultLabelHeight * 0.1
		let labelGridWidth = frame.width - labelGridWidthHeight * 2.0
		let labelGridHeight = frame.height - labelGridWidthHeight * 2.0
		let labelGridSize = CGSize(width: labelGridWidth, height: labelGridHeight)
		let labelGridOrigin = CGPoint(x: labelGridWidthHeight, y: labelGridWidthHeight)
		let labelGridRect = CGRect(origin: labelGridOrigin, size: labelGridSize)
		let labelGrid = UIView(frame: labelGridRect)
		labelGrid.layer.cornerRadius = 10.0
		labelGrid.layer.borderWidth = 1.0
		labelGrid.layer.borderColor = IOTColor.roundRectBoderColorBlue.uiColor(for: style).cgColor
		labelGrid.backgroundColor = IOTColor.labelBackground.uiColor(for: style)
		labelGrid.clipsToBounds = true
		addSubview(labelGrid)

		let (cardIconRect, viewComponentsRect) = DYSegmenter.horizontalTwo(
			rect: CGRect(origin: CGPoint.zero, size: labelGrid.frame.size),
			ratios: [0.1, 0.9],
			spaceRatio: defaultCardAndTextFieldHorzontalEdgeToParentWidth,
			edgeRatio: DYSegmenter.EdgeRatio(
				horizontal: defaultCardAndTextFieldHorzontalEdgeToParentWidth, vertical: 0.05
			)
		)

		let config = IOTSegmentModel.IOTSegmentModelConfig(
			parentRect: viewComponentsRect,
			deformConfig: deformConfig,
			spaceRatioToParent: defaultCardTextFieldHorzontalSpaceToParentWidth,
			edgeRatioToParent: DYSegmenter.EdgeRatio(horizontal: 0.0, vertical: 0.0))

		facade.setTextFieldsView(frame: labelGrid.frame)
		facade.setIOTCardView(frame: cardIconRect)
		facade.setSegmentModel(config: config)
		facade.layoutSubview()
		addSubview(facade.viewComponents)
	}
}
