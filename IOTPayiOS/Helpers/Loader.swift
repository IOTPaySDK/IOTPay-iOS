//
//  Loader.swift
//  IOTPayiOS
//
//  Created by macbook on 2021-04-22.
//


import UIKit

class Loader {

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

}


