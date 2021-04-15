//
//  ViewController.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

class ViewController: UIViewController {

	var cardInfoView: IOTCardInfoViewSingleLine!

	override func viewDidLoad() {
		super.viewDidLoad()

		cardInfoView = IOTCardInfoViewSingleLine(action: .addCard, style: .roundRect)
		cardInfoView.center.y = view.center.y - 100.0
		view.addSubview(cardInfoView)

		let button = UIButton()
		button.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)
		button.backgroundColor = .blue
		button.setTitle("Confirm", for: .normal)
		button.center = CGPoint(x: view.center.x, y: view.center.y)
		button.addTarget(self, action: #selector(onComfirm), for: .touchDown)
		view.addSubview(button)

	}

	@objc func onComfirm() {
		IOTNetworkManager.shared.sendRequest(secureId: "your secureId", cardInfoPrivder: cardInfoView)
	}

}

