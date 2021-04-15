//
//  ViewController.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-07.
//

import UIKit

class ViewController: UIViewController {

	var cardInfoView: IOTCardInfoViewTripleLineNCardView!
	var singleLineView: IOTCardInfoViewSingleLineNCardIcon!

	override func viewDidLoad() {
		super.viewDidLoad()

//		cardInfoView = IOTCardInfoViewTripleLineNCardView(action: .addCard, style: .roundRect)
//		cardInfoView.frame = CGRect(x: 0.0, y: 50.0,
//																width: view.frame.width, height: 350)
//		//cardInfoView.center.y = view.center.y - 100.0
//		view.addSubview(cardInfoView)
//
//		singleLineView = IOTCardInfoViewSingleLineNCardIcon(action: .addCard, style: .roundRect)
//		singleLineView.frame = CGRect(x: 0.0, y: 450, width: view.frame.width, height: 50)
//		view.addSubview(singleLineView)
//
//
		let label = UILabel()
		label.text = "IOTPay-iOS Demo"
		label.frame.size = CGSize(width: 300.0, height: 80.0)
		label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
		label.textAlignment = .center
		label.center = CGPoint(x: view.center.x, y: view.center.y - 200)
		view.addSubview(label)

		let titleArray = ["Simple Demo", "Single Line Demo", "Triple Line Demo"]
		for i in 0..<titleArray.count {
			let button = UIButton(type: .roundedRect)
			button.frame.size = CGSize(width: 300.0, height: 50.0)
			button.setTitle(titleArray[i], for: .normal)
			button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
			button.titleLabel?.textColor = .blue
			button.center.x = view.center.x
			button.center.y = view.center.y + (CGFloat(i) * 100.0)
			button.tag = i
			button.addTarget(self, action: #selector(onButton(sender:)), for: .touchDown)
			view.addSubview(button)
		}

	}

	@objc func onButton(sender: UIButton) {
		var nextViewController: UIViewController
		switch sender.tag {
			case 0:
				nextViewController = SimpleDemo()
			case 1:
				nextViewController = SingleLineDemo()
			case 2:
				nextViewController = TripleLineDemo()
			default:
				return
		}

		nextViewController.modalPresentationStyle = .fullScreen
		nextViewController.view.backgroundColor = .white
		present(nextViewController, animated: true, completion: nil)
//		dismiss(animated: true, completion: nil)
//		present(nextViewController, animated: true, completion: nil)
	}

}

