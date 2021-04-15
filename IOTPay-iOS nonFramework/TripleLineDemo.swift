//
//  TripleLineDemo.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-15.
//

import UIKit

class TripleLineDemo: SubViewControllerAbstract {

	var tripleLineView: IOTCardInfoViewTripleLineNCardView!

	override func viewDidLoad() {
		super.viewDidLoad()

		tripleLineView = IOTCardInfoViewTripleLineNCardView(action: .addCard, style: .roundRect)
		tripleLineView.frame = CGRect(x: 0.0, y: 50.0, width: view.frame.width, height: 350)
		view.addSubview(tripleLineView)
	}

	@objc override func onComfirm() {
		IOTNetworkManager.shared.sendRequest(secureId: "your secureId",
																				 cardInfoPrivder: tripleLineView)
	}
}
