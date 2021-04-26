//
//  IOTCardView.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-14.
//
import UIKit

class IOTCardView: UIView {

	private let cardWidthHeightRatio: CGFloat = 1.586

//	var current = UIView()
//	var nextOne = UIView()

	var facade: IOTCardInfoComponentsFacade!
	var side: CardFlipCycle = .front
	var brand: CardCulingCycle = .unrecognized
	var tillBrand: CardCulingCycle = .unrecognized

	var isInvalid: Bool = false

	var timer: Timer?

	var current = IOTCardImageView(frame: CGRect.zero)

	//var markView = CardMarkView(frame: CGRect.zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		IOTCardImageView.logoRect = nil
		current = makeCard(brand: .unrecognized, side: .front)
		addSubview(current)
		//backgroundColor = .red

//		markView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
//		markView.layoutRect()
//		addSubview(markView)
//
//		markView.play(color: .red)
	}

	func setView(width: CGFloat) {
		let height = width / cardWidthHeightRatio
		frame.size = CGSize(width: width, height: height)
	}


	func playFlipAnimation() {
		let card = makeCard(brand: brand, side: side.nextSide)
		addSubview(card)
		flip(fromView: current, toView: card)
		side = side.nextSide
	}

	func playCycleAnimation(till: CardCulingCycle) {
		tillBrand = till
		startCycleTimer()

	}

	func playInvalidAnimation() {

	}


	func checkStopTimer() {
		if tillBrand == brand {
			stopTimer()

		}
	}

	func startCycleTimer() {
		stopTimer()

		timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [weak self] (t) in
			if let self = self, t.isValid {
				let card = self.makeCard(brand: self.brand.nextCard, side: .front)
				self.addSubview(card)
				self.cycle(fromView: self.current, toView: card)
				self.brand = self.brand.nextCard
				self.checkStopTimer()
			}
		})
	}

	func stopTimer() {
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
	}

	deinit {
		stopTimer()
	}





	private func flip(fromView: IOTCardImageView, toView: IOTCardImageView) {
		UIView.transition(from: fromView, to: toView, duration: 0.4, options: [
			//.transitionCrossDissolve,
			.transitionFlipFromLeft
			//.transitionCurlDown
			//.transitionCurlUp, //.showHideTransitionViews
		])
		current = toView
	}

	func cycle(fromView: IOTCardImageView, toView: IOTCardImageView) {
		UIView.transition(from: fromView, to: toView, duration: 0.2, options: [
			//.transitionCrossDissolve,
			//.transitionFlipFromLeft
			//.transitionFlipFromTop
			//.transitionCurlDown
			.transitionCurlUp, //.showHideTransitionViews
		])
		current = toView
	}

	private func makeCard(brand: CardCulingCycle?, side: CardFlipCycle) -> IOTCardImageView {
		let card = IOTCardImageView(frame: CGRect(origin: CGPoint.zero, size: frame.size))
		card.setCard(brand: brand, side: side)
		return card
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

//	func aspectRatio() {
//		let size = aspectRatioFit(rect: frame.size, imageRatio: cardWidthHeightRatio)
//		frame.size = size
//	}

	func centering() {
		let origin = CGPoint(x: (frame.width - frame.size.width) * 0.5,
												 y: (frame.height - frame.size.height) * 0.5)
		frame.origin = origin
	}


	private func aspectRatioFit(rect: CGSize, image: UIImage?) -> CGSize {
		guard let image = image else { return CGSize.zero }
		let imageRatio = image.size.width / image.size.height
		return aspectRatioFit(rect: rect, imageRatio: imageRatio)
	}

	private func aspectRatioFit(rect: CGSize, imageRatio: CGFloat) -> CGSize {
		let width: CGFloat
		let height: CGFloat
		let rectRatio = rect.width / rect.height
		if rectRatio <= imageRatio {
			width = rect.width
			height = width / imageRatio
		} else {
			height = rect.height
			width = height * imageRatio
		}
		return CGSize(width: width, height: height)
	}



}
