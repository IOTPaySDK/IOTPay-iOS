//
//  IOTCardTypePerdicationModel.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-09.
//

import Foundation


final class IOTCardPatternPredictionModel {

	let filterModel = IOTInputFilterModel()

	init() {}

	func predicting(cardNumberText: String) -> IOTCardPatternPrediction {

		guard !cardNumberText.isEmpty, Int(cardNumberText) != nil else { return .unrecognized }
		
		let length = cardNumberText.count

		let prefixOne = String(cardNumberText.prefix(1))
		if length == 1 && Int(prefixOne) != nil,
			 let possiableBrands = IOTCardNumberRegulation.firstDigitPossiblePattern[prefixOne],
			 possiableBrands.count == 1 || Set(possiableBrands.map { $0.brand }).count == 1 {
			//Set(possiableBrands.map { $0.brand })
			return possiableBrands[0]
		}

		let prefixSix = String(cardNumberText.prefix(6))
		if length >= 6 && Int(prefixOne) != nil && prefixOne == "4" {
			if IOTCardNumberRegulation.visaFirstSixDigits.contains(prefixSix) {
				return .visa13
			}
			return .visa16
		}

		let prefixTwo = String(cardNumberText.prefix(2))
		//if length >= 2 && length < 6 && Int(prefixOne) != nil,
		if length >= 2 && Int(prefixOne) != nil,
			 let firstTwoDigitsInt = Int(prefixTwo),
			firstTwoDigitsInt > 10 {

			if let certainBrands = IOTCardNumberRegulation.firstDigitCertainPattern[prefixOne],
				 certainBrands.count == 1 || Set(certainBrands.map { $0.brand }).count == 1 {
				return certainBrands[0]
			}

			if let certainBrands = IOTCardNumberRegulation.firstTwoDigitsCertainPattern[prefixTwo],
				 certainBrands.count == 1 || Set(certainBrands.map { $0.brand }).count == 1 {
				return certainBrands[0]
			}
		}

		return .unrecognized
	}



	func predictingByFirstDigit(intString: String) -> IOTCardPatternPrediction {
	 switch intString {
	 case "4": return .visa16  //
	 case "5": return .master
	 //case "6": return .discover
	 default: return .unrecognized
	 }
 }

	func predictingByFirstTwoDigits(intString: String) -> IOTCardPatternPrediction {

		 switch intString.prefix(1) {
			 case "4": return .visa16
			 case "5": return .master
			 default: break
		 }

		 switch intString {
			 case "30", "38", "39": return .dinersClub16
			 case "34", "37": return .americanExpress
			 case "35": return .jcb
			 case "36": return .dinersClub14
			 case "60", "64", "65": return .discover
			 case "62", "81": return .unionPay
			 default: return .unrecognized
		 }
	}

	let firstSixDigitsForVisa13: Set<String> = [
		"413600", "444509", "444550", "450603", "450617","450628", "450629", "450636", "450636",
		"450640", "450641", "450662", "450662", "463100", "463100", "476142", "476142", "476143",
		"476143", "492901", "492902", "492920", "492923", "492928", "492929", "492930", "492937",
		"492939", "492960",
	]

	func predictingByFirstSixDigitsForVisa(intString: String) -> IOTCardPatternPrediction {
		firstSixDigitsForVisa13.contains(intString) ? .visa13 : .visa16
	}


	func filtering(text: String, for textFieldType: IOTTextFieldSubject) -> String {
		switch textFieldType {
		case .holderName: return retainAscii(text: text)
		case .cardNumber: return retainNumerical(text: text)
		case .expiryDate: return retainNumericalAndForwardSlash(text: text)
		case .cvv: return retainNumerical(text: text)
		}
	}

	private func retainNumerical(text: String) -> String {
		text.components(separatedBy: CharSet.numbericalFilter).joined()
	}

	private func retainNumericalAndForwardSlash(text: String) -> String {
		text.components(separatedBy: CharSet.dateFilter).joined()
	}

	private func retainAscii(text: String) -> String {
		text.components(separatedBy: CharSet.englishCharFilter).joined()
	}

}

