//
//  IOTCardIconImageView.swift
//  IOTPayUIPlayground
//
//  Created by macbook on 2021-03-29.
//

import UIKit

class IOTCardIconView: UIView {
	//constant
	//setting
	private let cardWidthHeightRatio: CGFloat = 1.586
	//view Elements
	private var iconImageView: UIImageView!

	private var imageName: String = "" {
		didSet { iconImageView.image = Loader.assetImage(named: imageName) }
	}

	var side: IOTCardSide = .front {
		didSet { imageName = side == .front ? state.imageName : side.imageName }
	}

	var state: IOTCardIconState = .unrecognized { didSet { imageName = state.imageName }}

	init() {
		super.init(frame: CGRect.zero)
	}

	init(cardFrame: CGRect) {
		super.init(frame: CGRect(origin: cardFrame.origin, size: cardFrame.size))
		commonInit()
	}

	init(origin: CGPoint, height: CGFloat) {
		let size = CGSize(width: height * cardWidthHeightRatio, height: height)
		super.init(frame: CGRect(origin: origin, size: size))
		commonInit()
	}

	init(segmentRect: CGRect) { // aspet either width or heigh then center
		super.init(frame: segmentRect)
		//super.init(frame: CGRect(origin: segmentRect.origin, size: segmentRect))
		commonInit()
	}

	func updateFrame() {
		commonInit()
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func commonInit() {
		let size = DYUIHelper.sizeAspect(fit: frame.size, cardWidthHeightRatio)
		let originX = (frame.width - size.width) * 0.5
		let originY = (frame.height - size.height) * 0.5
		let iconRect = CGRect(origin: CGPoint(x:originX, y: originY), size: size)
		iconImageView = UIImageView(frame: iconRect)
		iconImageView.image = Loader.assetImage(named: state.imageName)
		addSubview(iconImageView)
	}
}
