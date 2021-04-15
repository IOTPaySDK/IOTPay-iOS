//
//  IOTCardInfoViewSingleLine.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//




//enum IOTTextFieldCompostition {
//	case normal
//}

import UIKit

class IOTCardInfoViewSingleLine: IOTDeformableCardInfoView {


	//var viewComponents: IOTCardInfoComponents!
	//var cardIconView: IOTCardIconView!
	//var composition: IOTTextFieldCompostition
	let style: IOTCardInfoViewStyle

	private let defaultLabelHeight: CGFloat = 50.0
	//private let defaultLabelHorizontalSpacePortionToScreenWidth: CGFloat = 0.1
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

//	override init(layout: IOTCardInfoViewLayout, action: IOTNetworkRequestAction) {
//		super.init(layout: layout, action: action)
//	}


	init(action: IOTNetworkRequestAction, style: IOTCardInfoViewStyle? = nil) {
		self.style = style ?? .roundRect
		super.init(action: action, layout: .singleLineWithSmallCardIcon,
							 deformConfig: deformConfig)


	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func commonInit() {
		facade = IOTCardInfoComponentsFacade(action: action, layout: .singleLineWithSmallCardIcon, style: .roundRect)
		super.commonInit()
		defaultLayout()
	}

	private func defaultLayout() {
		frame = CGRect(x: 0, y: 0, width: screenW, height: defaultLabelHeight)
		backgroundColor = IOTColor.system5.uiColor


		let labelGridWidthHeight = defaultLabelHeight * 0.1
		let labelGridWidth = frame.width - labelGridWidthHeight * 2.0
		let labelGridHeight = frame.height - labelGridWidthHeight * 2.0
		let labelGridSize = CGSize(width: labelGridWidth, height: labelGridHeight)
		let labelGridOrigin = CGPoint(x: labelGridWidthHeight, y: labelGridWidthHeight)
		let labelGridRect = CGRect(origin: labelGridOrigin, size: labelGridSize)
		let labelGrid = UIView(frame: labelGridRect)
		labelGrid.layer.cornerRadius = 10.0
		labelGrid.layer.borderWidth = 1.0
		labelGrid.layer.borderColor = UIColor.blue.cgColor
		labelGrid.backgroundColor = .white
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

		print(cardIconRect)



//		let uiv = UIView(frame: cardIconRect)
//		uiv.backgroundColor = .yellow
//		addSubview(uiv)

//		let textFieldNilSeletionRectArray = DYSegmenter.horizontal(
//			rect: viewComponentsRect,
//			ratios: deformConfig.nilSeletionRatios,
//			spaceRatio: defaultCardTextFieldHorzontalSpaceToParentWidth,
//			edgeRatio: DYSegmenter.EdgeRatio(horizontal: 0.0, vertical: 0.0)
//		)



		let config = IOTSegmentModel.IOTSegmentModelConfig(
			parentRect: viewComponentsRect,
			deformConfig: deformConfig,
			spaceRatioToParent: defaultCardTextFieldHorzontalSpaceToParentWidth,
			edgeRatioToParent: DYSegmenter.EdgeRatio(horizontal: 0.0, vertical: 0.0))



		facade.setTextFieldsView(frame: labelGrid.frame)
		facade.setCardView(frame: cardIconRect)
		facade.setSegmentModel(config: config)
		facade.layoutSubview()
		addSubview(facade.viewComponents)

		



//		viewComponents = IOTCardInfoComponents(layout: layout)
//		viewComponents.frame = frame
//		viewComponents

//		cardIconView = IOTCardIconView(cardFrame: cardIconRect)
//		addSubview(cardIconView)

		//viewComponents = IOTCardInfoComponents(layout: .singleLineWithSmallCardIcon)
//		for (i, textField) in viewComponents.textFields.enumerated() {
//			textField.displayState = singleLineComponetsWidthRatioAtState.initDisplayState[i]
//			textField.frame = textFieldnilSeletionRectArray[i]
//			//textField.backgroundColor = .yellow
//			addSubview(textField)
//		}


		//viewComponents.delegate = self

		//viewComponents.cardInfo

//		for rect in rectArray {
//			let view = UIView(frame: rect)
//			view.backgroundColor = .yellow
//			addSubview(view)
//		}


	}

}

extension IOTCardInfoViewSingleLine: IOTCardInfoComponentsDelegate {
	func onDidComplete(isValid: Bool) {
		if isValid { print("done and valid") }
		else { print("done with error") }
	}
	
}

//extension IOTCardInfoViewSingleLine {
//	enum Style {
//		case roundRect
//		case infoLight
//		case infoDark
//	}
//}
