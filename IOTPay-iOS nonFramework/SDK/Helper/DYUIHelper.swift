//
//  fdsfew.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-14.
//

import Foundation

import UIKit

class DYUIHelper {

//	static var helper: DYUIHelper = {
//		return DYUIHelper()
//	}()

	static func height(byWidth: CGFloat, _ ofImage: UIImage?) -> CGFloat {
		guard let ofImage = ofImage else {
			return 0.0
		}
		let ratio = ofImage.size.width / ofImage.size.height
		return byWidth / ratio
	}

	static func width(byHeight: CGFloat, _ ofImage: UIImage?) -> CGFloat {
		guard let ofImage = ofImage else {
			return 0.0
		}
		let ratio = ofImage.size.width / ofImage.size.height
		return byHeight * ratio
	}

	static func size(byWidth: CGFloat, _ ofImage: UIImage?) -> CGSize {
		guard let ofImage = ofImage else {
			return CGSize.zero
		}
		let ratio = ofImage.size.width / ofImage.size.height
		return CGSize(width: byWidth, height: byWidth / ratio)
	}

	static func scale(byWidth: CGFloat, _ ofImage: UIImage?) -> CGFloat {
		guard let ofImage = ofImage else {
			return CGFloat.zero
		}
		return byWidth / ofImage.size.width
	}

	static func size(byHeight: CGFloat, _ ofImage: UIImage?) -> CGSize {
		guard let ofImage = ofImage else {
			return CGSize.zero
		}
		let ratio = ofImage.size.width / ofImage.size.height
		return CGSize(width: byHeight * ratio, height: byHeight)
	}

	static func scale(byHeight: CGFloat, _ ofImage: UIImage?) -> CGFloat {
		guard let ofImage = ofImage else {
			return CGFloat.zero
		}
		return byHeight / ofImage.size.height
	}

	static func size(byScale: CGFloat, _ ofImage: UIImage?) -> CGSize {
		guard let ofImage = ofImage else {
			return CGSize.zero
		}
		let width = ofImage.size.width * byScale
		let height = ofImage.size.height * byScale
		return CGSize(width: width, height: height)
	}


	static func sizeAspect(fit: CGSize, _ ofImage: UIImage?) -> CGSize {
		guard let ofImage = ofImage else {
			return CGSize(width: 0.0, height: 0.0)
		}
		let imageRatio = ofImage.size.width / ofImage.size.height
		let rectRatio = fit.width / fit.height
		var resWidth = CGFloat.zero
		var resHeight = CGFloat.zero
		if rectRatio <= imageRatio {
			//max width, less height
			resWidth = fit.width
			resHeight = resWidth / imageRatio
		} else {
			resHeight = fit.height
			resWidth = imageRatio * resHeight
		}
		return CGSize(width: resWidth, height: resHeight)
	}

	static func sizeAspect(fit: CGSize, _ imageRatio: CGFloat) -> CGSize {
		let imageRatio = imageRatio
		let rectRatio = fit.width / fit.height
		var resWidth = CGFloat.zero
		var resHeight = CGFloat.zero
		if rectRatio <= imageRatio {
			//max width, less height
			resWidth = fit.width
			resHeight = resWidth / imageRatio
		} else {
			resHeight = fit.height
			resWidth = imageRatio * resHeight
		}
		return CGSize(width: resWidth, height: resHeight)
	}

	static func sizeAspect(extent: CGSize, _ ofImage: UIImage?) -> CGSize {
		guard let ofImage = ofImage else {
			return CGSize(width: 0.0, height: 0.0)
		}
		let imageRatio = ofImage.size.width / ofImage.size.height
		let rectRatio = extent.width / extent.height
		var resWidth = CGFloat.zero
		var resHeight = CGFloat.zero
		if rectRatio <= imageRatio {
			//max width, less height
			resHeight = extent.height
			resWidth = imageRatio * resHeight
		} else {
			resWidth = extent.width
			resHeight = resWidth / imageRatio
		}
		return CGSize(width: resWidth, height: resHeight)
	}

	static func sizeAspect(extent: CGSize, _ ofImageSize: CGSize) -> CGSize {
		let imageRatio = ofImageSize.width / ofImageSize.height
		let rectRatio = extent.width / extent.height
		var resWidth = CGFloat.zero
		var resHeight = CGFloat.zero
		if rectRatio <= imageRatio {
			//max width, less height
			resHeight = extent.height
			resWidth = imageRatio * resHeight
		} else {
			resWidth = extent.width
			resHeight = resWidth / imageRatio
		}
		return CGSize(width: resWidth, height: resHeight)
	}

	static func sizeAspect(extent: CGSize, _ imageRatio: CGFloat) -> CGSize {
		let imageRatio = imageRatio
		let rectRatio = extent.width / extent.height
		var resWidth = CGFloat.zero
		var resHeight = CGFloat.zero
		if rectRatio <= imageRatio {
			//max width, less height
			resHeight = extent.height
			resWidth = imageRatio * resHeight
		} else {
			resWidth = extent.width
			resHeight = resWidth / imageRatio
		}
		return CGSize(width: resWidth, height: resHeight)
	}


	static func ratio(ofImage: UIImage) -> CGFloat {
		return ofImage.size.width / ofImage.size.height
	}


}

//defaults write com.apple.iphonesimulator ShowSingleTouches 1
