////
////  IOTCardInfoComponentsView.swift
////  IOTPay-iOS nonFramework
////
////  Created by macbook on 2021-04-13.
////
//
//import UIKit
//
//final class IOTCardInfoComponentsView: UIView {
//
//	private var viewComponents: IOTCardInfoComponents
//
//	init(layout: IOTCardInfoViewLayout, style: IOTCardInfoViewStyle) {
//		viewComponents = IOTCardInfoComponents(layout: layout, style: style)
//		super.init(frame: CGRect.zero)
//		commonInit(layout: layout)
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//
//
//	private func commonInit(layout: IOTCardInfoViewLayout) {
//		viewComponents.textFields.forEach {
//			addSubview($0)
//			$0.addTarget(viewModel, action: #selector(viewModel.onTextFieldDidSelect(sender:)), for: .editingDidBegin)
//			$0.addTarget($0.viewModel, action: #selector($0.viewModel.onTextFieldDidChange(sender:)), for: .editingChanged)
//		}
//
//		if layout.isDisplayingCardIcon { addSubview(cardIconView!) }
//	}
//}
