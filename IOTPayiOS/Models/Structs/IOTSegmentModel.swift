//
//  IOTSegmentModel.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-13.
//

import UIKit

final class IOTSegmentModel {

	var name: String?
	var config: IOTSegmentModelConfig!
	
	init() {}

	func rectArr(for state: IOTTextFieldSubject?) -> [CGRect] {

		let ratios = config.deformConfig.ratios(forState: state)

		return DYSegmenter.horizontal(
			rect: CGRect(origin: config.parentRect.origin, size: config.parentRect.size),
			ratios: ratios,
			spaceRatio: config.spaceRatioToParent,
			edgeRatio: config.edgeRatioToParent
		)
	}


}

extension IOTSegmentModel {
	struct IOTSegmentModelConfig {
		let parentRect: CGRect
		let deformConfig: IOTDeformConfig
		let spaceRatioToParent: CGFloat
		let edgeRatioToParent: DYSegmenter.EdgeRatio
	}
}

