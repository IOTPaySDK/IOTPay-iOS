//
//  Loader.swift
//  IOTPayiOS
//
//  Created by macbook on 2021-04-22.
//


import UIKit

class Loader {

//	static func png(named: String) -> UIImage? {
//
//		let podBundle = Bundle(for: Loader.self)
//		if let url = podBundle.url(forResource: "IOTPayiOS/Images", withExtension: ".png") {
//			let bundle = Bundle(url: url)
//			let uiImage = UIImage(named: named, in: bundle, compatibleWith: nil)
//			return uiImage
//		}
//		return nil
//	}
//
//	static func image(named: String) -> UIImage? {
//		let podBundle = Bundle(for: Loader.self)
//		if let url = podBundle.url(forResource: "Assets", withExtension: "bundle") {
//			let bundle = Bundle(url: url)
//			let uiImage = UIImage(named: named, in: bundle, compatibleWith: nil)
//			return uiImage
//		} else {
//			return nil
//		}
//	}
//
//	static func bundledImage(named: String) -> UIImage? {
//
//		if let path =  Bundle(for: Loader.self).path(forResource: "Assets", ofType: "bundle") {
//			let assetsBundle = Bundle(path: path)
//			let image = UIImage(named: named, in: assetsBundle, compatibleWith: nil)
//			return image
//		} else {
//			return nil
//		}
//
//	}

	static func assetImage(named: String) -> UIImage? {
		let image = UIImage(named: named, in: Bundle(for: self), compatibleWith: nil)

		if image != nil { // in development environment
			return image
		} else { // in pod
			if let url = Bundle(for: self).url(forResource: "IOTPayiOS", withExtension: "bundle"),
				 let bundle = Bundle(url: url) {
				return UIImage(named: named, in: bundle, compatibleWith: nil)
			} else {
				print("Can't find IOTPayiOS Images")
				return nil
			}
		}
	}


//	static func bundledImage2(named: String) -> UIImage? {
//
//		if let path = Bundle(for: Loader.self).path(forResource: "ResourcesAssets", ofType: "bundle") {
//			let assetsBundle = Bundle(path: path)
//			let image = UIImage(named: named, in: assetsBundle, compatibleWith: nil)
//			//print(named, assetsBundle?.bundlePath, image == nil)
//			return image
//		} else {
//			//print("assets not found")
//			return nil
//		}
//	}
}


