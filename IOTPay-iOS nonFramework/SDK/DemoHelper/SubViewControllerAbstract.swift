//
//  SubViewControllerAbstract.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-15.
//

import UIKit

class SubViewControllerAbstract: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupButtons()
	}

	func setupButtons() {
		let comfirmButton = UIButton(type: .roundedRect)
		comfirmButton.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 40.0)
		comfirmButton.setTitle("Confirm", for: .normal)
		comfirmButton.center = CGPoint(x: view.center.x, y: 450 + 50 + 100)
		comfirmButton.addTarget(self, action: #selector(onComfirm), for: .touchDown)
		view.addSubview(comfirmButton)

		let backButton = UIButton(type: .roundedRect)
		backButton.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 40.0)
		backButton.setTitle("Back to Main Menu", for: .normal)
		backButton.center = CGPoint(x: view.center.x, y: 450 + 50 + 200)
		backButton.addTarget(self, action: #selector(onBack), for: .touchDown)
		view.addSubview(backButton)
	}

	@objc func onComfirm() {}

	@objc func onBack() {
		let nextViewController = ViewController()
		nextViewController.modalPresentationStyle = .fullScreen
		nextViewController.view.backgroundColor = .white
		present(nextViewController, animated: true, completion: nil)
	}
}
