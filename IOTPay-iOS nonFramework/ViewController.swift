//
//  ViewController.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

class ViewController: UIViewController {

	//var cardInfoView: IOTCardInfoView!
	var addUserButton: UIButton!
	let secureId = "secureIdabcabcabc"

	override func viewDidLoad() {
		super.viewDidLoad()

		let singleLine = IOTCardInfoViewSingleLine(action: .addUser, style: .roundRect)
		singleLine.frame.origin = CGPoint(x: 0, y: 500)
		view.addSubview(singleLine)


		let tripleLine =  IOTCardInfoViewSingleLine(action: .addUser, style: .roundRect)
		tripleLine.frame.origin = CGPoint(x: 0, y: 100)
		view.addSubview(tripleLine)


	}
}

