//
//  IOTDeformableCardInfoView.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

import UIKit

protocol Deformable {
	func setLabelLocations(to state: IOTTextFieldSubject)
	func relocating(fromState: IOTTextFieldSubject, toState: IOTTextFieldSubject, animation: Bool, duration: TimeInterval)
}


public class IOTDeformableCardInfoView: IOTCardInfoView {
	let deformConfigMater: IOTDeformConfig


	
	public init(action: IOTNetworkRequestAction, layout: IOTCardInfoViewLayout, style: IOTCardInfoViewStyle, deformConfig: IOTDeformConfig) {
		self.deformConfigMater = deformConfig
		super.init(action: action, layout: layout, style: style)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension IOTDeformableCardInfoView: Deformable {
	func setLabelLocations(to state: IOTTextFieldSubject) {
		//todo
	}

	func relocating(fromState: IOTTextFieldSubject, toState: IOTTextFieldSubject, animation: Bool, duration: TimeInterval) {
		//uianimate
	}
}
