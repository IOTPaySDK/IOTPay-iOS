//
//  SimpleDemoa.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-15.
//

import UIKit


class SimpleDemo: SubViewControllerAbstract {

	var simpleView: IOTCardInfoViewSingleLineNCardIcon!

	override func viewDidLoad() {
		super.viewDidLoad()

		simpleView = IOTCardInfoViewSingleLineNCardIcon(action: .addCard, style: .roundRect)
		simpleView.frame = CGRect(x: 0.0, y: 260, width: view.frame.width, height: 50)
		view.addSubview(simpleView)
	}

	@objc override func onComfirm() {
		IOTNetworkManager.shared.sendRequest(secureId: "your secureId",
																				 cardInfoPrivder: simpleView)
	}

}

