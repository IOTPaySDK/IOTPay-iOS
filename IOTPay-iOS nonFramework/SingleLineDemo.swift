//
//  SingleLineDemo.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-15.
//

import UIKit

class SingleLineDemo: SubViewControllerAbstract {

	var singleLineView: IOTCardInfoViewSingleLineNCardIcon!

	override func viewDidLoad() {
		super.viewDidLoad()

		singleLineView = IOTCardInfoViewSingleLineNCardIcon(action: .addCard, style: .roundRect)
		singleLineView.frame = CGRect(x: 0.0, y: 260, width: view.frame.width, height: 50)
		view.addSubview(singleLineView)
	}

	@objc override func onComfirm() {
		IOTNetworkManager.shared.sendRequest(secureId: "your secureId",
																				 cardInfoPrivder: singleLineView)
	}
}
