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
	var button: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		/*
		For a more detailed guide,
		please visit: https://github.com/IOTPaySDK/IOTPay-iOS
		*/

		/* Setup IOT card info view, you can choose from any layouts below:
		IOTCardInfoViewSingleLineNCardIcon
		IOTCardInfoViewTripleLineNCardView
		IOTCardInfoViewTripleLine
		We will use IOTCardInfoViewSingleLineNCardIcon in this example
		action: (enum) either .addCard or .oneTimePurchase
		style: (enum) Choose any style fit your app.
		For auto - Nightmode detection, please use .autoNightmode
		*/
		cardInfoView = IOTCardInfoViewSingleLineNCardIcon(action: .addCard, style: .forceDarkMode)
		cardInfoView.frame.origin = CGPoint(x: 0.0, y: 50.0)
		/* set delegate
		this is the IOTCardInfoViewDelegate,
		which will let you know when user the input correctly
		*/
		cardInfoView.delegate = self
		view.addSubview(cardInfoView)


		/* make a button for submit network request once user finished input,
		starts as interation Enabled state
		*/
		button = UIButton(frame: CGRect(x: view.frame.width * 0.5 - 150.0,
																		y: cardInfoView.frame.height + 50.0 + 100.0,
																		width: 300.0, height: 50.0))
		button.setTitleColor(.systemBlue, for: .normal)
		button.setTitle("Please enter card info", for: .normal)
		button.isUserInteractionEnabled = false
		button.addTarget(self, action: #selector(onButton), for: .touchDown)
		view.addSubview(button)
	}

	@objc func onButton() {
		/* Send network request for your action.
		The action is set in cardInfoView's init param.
		For production, client should build their own "Merchant Server",
		which will generate this secureId. For testing, you can use a
		temporary solution, detailed in github guide:
		https://github.com/IOTPaySDK/IOTPay-iOS
		*/
		let shared = IOTNetworkService.shared
		shared.delegate = self
		shared.sendRequest(secureId: "Your secureId", cardInfoView: cardInfoView)
	}


}

extension ViewController: IOTCardInfoViewDelegate {
	func onDidCompleteValidate() {
		// User did complete card info view Validate, we should enable the button
		button.setTitle("Add Card", for: .normal)
		button.isUserInteractionEnabled = true
	}
}

extension ViewController: IOTNetworkServiceDelegate {
	func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {
		/* .addCard action's network response if successd.
		There is a error checklist in the github guide to help you fix the error
		*/
		print("successd", desensitizedCardInfo.info)
	}

	func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {
		/* .oneTimePurchase action's network response if successd.
		There is a error checklist in the github guide to help you fix the error
		*/
		print("successd", purchaseReceipt.info)
	}


}

