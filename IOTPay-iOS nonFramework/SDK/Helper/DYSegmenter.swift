//
//  fdsa.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-14.
//

import Foundation

import UIKit

class DYSegmenter {

	struct EdgeRatio {
		let left: CGFloat?
		let right: CGFloat?
		let top: CGFloat?
		let bottom: CGFloat?

		init(horizontal: CGFloat?, vertical: CGFloat?) {
			self.left = horizontal
			self.right = horizontal
			self.top = vertical
			self.bottom = vertical
		}

		init(left: CGFloat?, right: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
			self.left = left
			self.right = right
			self.top = top
			self.bottom = bottom
		}
	}

	//MARK: Vertical
	static func verticalTwo(rect: CGRect, ratios: [CGFloat]? = nil, spaceRatio: CGFloat? = nil, edgeRatio: EdgeRatio? = nil) -> (left: CGRect, right: CGRect) {
		let rectArr = vertical(rect: rect, segmentCount: 2, ratios: ratios, spaceRatio: spaceRatio, edgeRatio: edgeRatio)
		return (left: rectArr[0], right: rectArr[1])
	}

	static func verticalThree(rect: CGRect, ratios: [CGFloat]? = nil, spaceRatio: CGFloat? = nil, edgeRatio: EdgeRatio? = nil) -> (left: CGRect, middle: CGRect, right: CGRect) {
		let rectArr = vertical(rect: rect, segmentCount: 3, ratios: ratios, spaceRatio: spaceRatio, edgeRatio: edgeRatio)
		return (left: rectArr[0], middle: rectArr[1], right: rectArr[2])
	}

	static func vertical(rect: CGRect, segmentCount: Int? = nil, ratios: [CGFloat]? = nil, spaceRatio: CGFloat? = nil, edgeRatio: EdgeRatio? = nil) -> [CGRect] {
//		if (segmentCount == nil && ratios == nil) {
//			fatalError("Invalid segmentCount, either use \"Two\", \"Three\", segmentCount Or enter ratio")
//		}
		if segmentCount != nil && ratios != nil && segmentCount! != ratios!.count {
			fatalError("Invalid ratio Array, it's not same as ratio.count")
		}
		guard let count = segmentCount ?? ratios?.count else {
			fatalError("Invalid segmentCount, either use \"Two\", \"Three\", segmentCount Or enter ratio")
		}

		let body = edgeRatio == nil ? rect : bodyRect(rect: rect, edgeRatio: edgeRatio!)

		let afterSpacingHeight = spaceRatio == nil ? body.height : body.height - totalVerticalSpacing(rect: rect, count: count, spaceRatio: spaceRatio!)
		let segmentHeights = segmentLengths(afterSpacingLength: afterSpacingHeight, count: count, ratios: ratios)
		let startX = rect.origin.x + (edgeRatio?.left ?? 0.0) * rect.width
		let startY = rect.origin.y + (edgeRatio?.top ?? 0.0) * rect.height

		var result = [CGRect]()
		var stackY: CGFloat = 0.0
		segmentHeights.forEach {
			result.append(CGRect(x: startX, y:  startY + stackY, width: body.width, height: $0))
			stackY += $0 + (spaceRatio ?? 0.0) * rect.height
		}

		return result
	}

	//MARK: Horizontal
	static func horizontalTwo(rect: CGRect, ratios: [CGFloat]? = nil, spaceRatio: CGFloat? = nil, edgeRatio: EdgeRatio? = nil) -> (top: CGRect, bottom: CGRect) {
		let rectArr = horizontal(rect: rect, segmentCount: 2, ratios: ratios, spaceRatio: spaceRatio, edgeRatio: edgeRatio)
		return (top: rectArr[0], bottom: rectArr[1])
	}

	static func horizontalThree(rect: CGRect, ratios: [CGFloat]? = nil, spaceRatio: CGFloat? = nil, edgeRatio: EdgeRatio? = nil) -> (top: CGRect, middle: CGRect, bottom: CGRect) {
		let rectArr = vertical(rect: rect, segmentCount: 3, ratios: ratios, spaceRatio: spaceRatio, edgeRatio: edgeRatio)
		return (top: rectArr[0], middle: rectArr[1], bottom: rectArr[2])
	}

	static func horizontal(rect: CGRect, segmentCount: Int? = nil, ratios: [CGFloat]? = nil, spaceRatio: CGFloat? = nil, edgeRatio: EdgeRatio? = nil) -> [CGRect] {

		let count = checkCount(segmentCount: segmentCount, ratios: ratios)
		let body = edgeRatio == nil ? rect : bodyRect(rect: rect, edgeRatio: edgeRatio!)
		let afterSpacingWidth = spaceRatio == nil ? body.width : body.width - totalHorizontalSpacing(rect: rect, count: count, spaceRatio: spaceRatio!)
		let segmentWidths = segmentLengths(afterSpacingLength: afterSpacingWidth, count: count, ratios: ratios)
		let startX = rect.origin.x + (edgeRatio?.left ?? 0.0) * rect.width
		let startY = rect.origin.y + (edgeRatio?.top ?? 0.0) * rect.height
		//print("afterSpacingWidth", afterSpacingWidth, segmentWidths, totalHorizontalSpacing(rect: rect, count: count, spaceRatio: spaceRatio!))
		var result = [CGRect]()
		var stackX: CGFloat = 0.0

//		print("body", body)
//		print("afterSpacingWidth", afterSpacingWidth)
//		print("segmentWidths", segmentWidths)
		segmentWidths.forEach {
			result.append(CGRect(x: startX + stackX, y:  startY, width: $0, height: body.height))
			stackX += $0 + (spaceRatio ?? 0.0) * rect.width
		}

		return result
	}

	//MARK: private helper

	private static func totalVerticalSpacing(rect: CGRect, count: Int, spaceRatio: CGFloat) -> CGFloat {
		spaceTotalRatio(count: count, spaceRatio: spaceRatio) * rect.height
	}

	private static func totalHorizontalSpacing(rect: CGRect, count: Int, spaceRatio: CGFloat) -> CGFloat {
		spaceTotalRatio(count: count, spaceRatio: spaceRatio) * rect.width
	}

	// common helper for both vertical and horizontal
	private static func checkCount(segmentCount: Int?, ratios: [CGFloat]?) -> Int {
		if segmentCount != nil && ratios != nil && segmentCount! != ratios!.count {
			fatalError("Invalid ratio Array, it's not same as ratio.count")
		}
		guard let count = segmentCount ?? ratios?.count else {
			fatalError("Invalid segmentCount, either use \"Two\", \"Three\", segmentCount Or enter ratio")
		}
		return count
	}

	static func bodyRect(rect: CGRect, edgeRatio: EdgeRatio) -> CGRect {
		let originX = edgeRatio.left == nil ? rect.origin.x : rect.origin.x + edgeRatio.left! * rect.width
		let originY = edgeRatio.top == nil ? rect.origin.y : rect.origin.y + edgeRatio.top! * rect.height
		//let width = (1.0 - (edgeRatio.left ?? 0.0) - (edgeRatio.right ?? 0.0)) * rect.width
		// for complaior speed, above line divied in to below lines:
		let leftRatio = edgeRatio.left ?? 0.0
		let rightRatio = edgeRatio.right ?? 0.0
		let bodyHorzontalRatio = 1.0 - leftRatio - rightRatio
		let bodyWidth = bodyHorzontalRatio * rect.width
		let topRatio = edgeRatio.top ?? 0.0
		let bottomRatio = edgeRatio.bottom ?? 0.0
		let bodyVerticalRatio = 1.0 - topRatio - bottomRatio
		let bodyHeight = bodyVerticalRatio * rect.height

		return CGRect(x: originX, y: originY, width: bodyWidth, height: bodyHeight)
	}

	private static func segmentLengthsAutoMaxOne(afterSpacingLength: CGFloat, count: Int, ratios: [CGFloat]?) -> [CGFloat] {
		// long vesion:
//		if let ratios = ratios {
//			return ratios.map { $0 * bodyLengthAfterSpacing }
//		} else {
//			let length = bodyLengthAfterSpacing / CGFloat(count)
//			return Array(repeating: length, count: count)
//		}
		if let ratios = ratios, !ratios.isEmpty {
			let sum = ratios.reduce(0, +)
			return ratios.map { $0 / sum * afterSpacingLength}
		} else {
			return Array(repeating: afterSpacingLength / CGFloat(count), count: count)
		}

	}

	private static func segmentLengths(afterSpacingLength: CGFloat, count: Int, ratios: [CGFloat]?) -> [CGFloat] {
		// long vesion:
		if let ratios = ratios {
			return ratios.map { $0 * afterSpacingLength }
		} else {
			let length = afterSpacingLength / CGFloat(count)
			return Array(repeating: length, count: count)
		}


	}

	private static func spaceTotalRatio(count: Int, spaceRatio: CGFloat) -> CGFloat {
		CGFloat(count - 1) * spaceRatio
	}

//	static func verticalWithRatio()
//
//	static func verticalEqually(rect: CGRect, spacing: CGFloat? = nil, edgePortion: EdgePortion?) -> (left: CGRect, right: CGRect) {
//
//	}
//
//	static func verticalEqually(rect: CGRect, count: Int, spacing: CGFloat? = nil, edgePortion: EdgePortion?) -> [CGRect] {
//
//	}
//
//	static func vertical(rect: CGRect, portionArr: [CGFloat], spacing: CGFloat? = nil, edgePortion: EdgePortion?) -> [CGRect] {
//
//	}
}
