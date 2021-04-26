//
//  ViewController.swift
//  AddCardSwiftExample
//
//  Created by macbook on 2021-04-25.
//

import UIKit
import IOTPayiOS

class ViewController: UIViewController {

	var cardInfoView: IOTCardInfoViewSingleLineNCardIcon!

	override func viewDidLoad() {
		super.viewDidLoad()

		cardInfoView = IOTCardInfoViewSingleLineNCardIcon(action: .oneTimePurchase, style: .roundRect)
		cardInfoView.center = view.center
		view.addSubview(cardInfoView)

		let button = UIButton(frame: CGRect(x: view.frame.width * 0.5 - 100.0, y: view.frame.height - 100.0, width: 200.0, height: 50.0))
		button.setTitleColor(.blue, for: .normal)
		button.setTitle("Add Card", for: .normal)
		button.addTarget(self, action: #selector(onButton), for: .touchDown)
		view.addSubview(button)

	}

	@objc func onButton() {
		IOTNetworkService.shared.delegate = self
		IOTNetworkService.shared.sendRequest(secureId: "caf11c8ee513cd55833217f3cfd2d48872dbc1ec50e192e0bca13b7063259d21", cardInfoView: cardInfoView)
	}


}

extension ViewController: IOTNetworkServiceDelegate {
	func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {
		print("successd", desensitizedCardInfo.info)
	}

	func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {
		print("successd", purchaseReceipt.info)
	}


}

