//
//  IOTCardBrandToNumber.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//



final class IOTCardNumberRegulation {

	static let firstDigitPossiblePattern: [String: [IOTCardPatternPrediction]] = [
		"2": [.master],
		"3": [.americanExpress, .dinersClub14, .dinersClub16, .jcb],
		"4": [.visa13, .visa16],
		"5": [.master],
		"6": [.discover, .unionPay],
		"8": [.unionPay],
	]

	static let firstDigitCertainPattern: [String: [IOTCardPatternPrediction]] = [
		"4": [.visa13, .visa16],
		"5": [.master],
	]

	static let firstTwoDigitsCertainPattern: [String: [IOTCardPatternPrediction]] = [
		"22": [.master], "23": [.master], "24": [.master], "25": [.master], "26": [.master],
		"27": [.master],
		"30": [.dinersClub16],
		"34": [.americanExpress],
		"35": [.jcb],
		"36": [.dinersClub14],
		"37": [.americanExpress],
		"38": [.dinersClub16],
		"39": [.dinersClub16],
//		"4X": [.visa13, .visa16],
//		"5X": [.master],
		"60": [.discover],
		"62": [.unionPay],
		"64": [.discover],
		"65": [.discover],
		"67": [.master],
		"81": [.unionPay],
	]

	static let visaFirstSixDigits: Set<String> = [
		"413600", "444509", "444550", "450603", "450617", "450628", "450629", "450636", "450636",
		"450640", "450641", "450662", "450662", "463100", "463100", "476142", "476142", "476143",
		"476143", "492901", "492902", "492920", "492923", "492928", "492929", "492930", "492937",
		"492939", "492960",
	]
}

//final class IOTCardCvvRegulation {
//
//	static let patternToDigits: [IOTCardPatternPrediction: Int] = [
//		.visa13: 3,
//		.visa16: 3,
//		.master: 4,
//		.americanExpress: 3,
//		.discover: 3,
//		.dinersClub14: 3,
//		.dinersClub16: 3,
//		.unionPay: 3,
//		.jcb: 3,
//		.unrecognized: -3, //toCheck
//	]
//}

import Foundation

final class CharSet {
	static let numerical: String = "0123456789"
	static let forwardSlash = "/"
	static let englishCharAndSpace = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIGKLMNOPQRSTUVWXYZ" //toCheck

	static let numbericalFilter = CharacterSet(charactersIn: CharSet.numerical).inverted
	static let dateFilter = CharacterSet(
		charactersIn:CharSet.numerical + CharSet.forwardSlash).inverted
	static let englishCharFilter = CharacterSet(
		charactersIn: CharSet.numerical + CharSet.englishCharAndSpace).inverted
}

