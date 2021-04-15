//
//  IOTCardImageView.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-14.
//

import UIKit

class IOTCardImageView: UIImageView {

	private let cardWidthHeightRatio: CGFloat = 1.586
	private let logoWidthHeightRatio: CGFloat = 2.543
	private let logoWidthToCardWidth: CGFloat = 0.45
	private let topEdgeToCardHeight: CGFloat = 0.12
	private let rightEdgeToCardWidth: CGFloat = 0.05

	static var logoRect: CGRect?

	var side: CardFlipCycle = .front
	var brand: CardCulingCycle? = .unrecognized

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setCard(brand: CardCulingCycle?, side: CardFlipCycle) {
		self.side = side
		self.brand = brand
		setBackground()
		setLogo()
	}

	private func setBackground() {
		image = UIImage(named: side.imageName)
	}

	private func setLogo() {
		if let brand = brand, let name = brand.imageName, side == .front {
			let logo = UIImageView(frame: logoFrame)
			logo.image = UIImage(named: name)
			addSubview(logo)
		}
	}

	private var logoFrame: CGRect {
		guard IOTCardImageView.logoRect == nil else { return IOTCardImageView.logoRect! }
		let width = logoWidthToCardWidth * frame.width
		let height = width / logoWidthHeightRatio
		let originX = frame.width - width - frame.width * rightEdgeToCardWidth
		let originY = frame.height * topEdgeToCardHeight
		IOTCardImageView.logoRect = CGRect(x: originX, y: originY, width: width, height: height)
		return IOTCardImageView.logoRect!
	}
}
enum CardFlipCycle {
	case front, back

	var imageName: String {
		switch self {
			case .front: return "frontAlmost"
			case .back: return "backAlmost"
		}
	}

	var nextSide: CardFlipCycle {
		switch self {
			case .front: return .back
			case .back: return .front
		}
	}
}

enum CardCulingCycle {
	case unrecognized, diner, visa, jcb, ame, discover, master
	var imageName: String? {
		switch self {
			case .unrecognized: return nil
			case .diner: return "dinerLarge"
			case .visa: return "visaLarge"
			case .jcb: return "jcbLarge"
			case .ame: return "ameLarge"
			case .discover: return "discoverLarge"
			case .master: return "masterLarge"
		}
	}

	var nextCard: CardCulingCycle {
		switch self {
			case .unrecognized: return .diner
			case .diner: return .visa
			case .visa: return .jcb
			case .jcb: return .ame
			case .ame: return .discover
			case .discover: return .master
			case .master: return .unrecognized
		}
	}

//	mutating func cycle() {
//		switch self {
//			case .unrecognized: self = .diner
//			case .diner: self = .visa
//			case .visa: self = .jcb
//			case .jcb: self = .ame
//			case .ame: self = .discover
//			case .discover: self = .master
//			case .master: self = .unrecognized
//		}
//	}
}
