//
//  IOTLanguageAndText.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-10.
//

//import Foundation

/*


case .cardNumber: return "Card No."
case .cvv: return "CVV"
case .expiryDate: return "MM/YY"
case .holderName: return "Name"
}
}

var normalPlaceholder: String {
switch self {
case .cardNumber: return "Card number"
case .cvv: return "CVV on the back"
case .expiryDate: return "MM/YY"
case .holderName: return "First & Last name of the holder"
*/

final class IOTLanguageAndText {

	static let current = english

	static var pack: IOTLanguagePack { current }

	static let english = IOTLanguagePack(
		textFieldPlaceHolder: [
			.cardNumber: "Card Number",
			.holderName: "Holder's First & Last Name",
			.expiryDate: "MM/YY",
			.cvv: "CVV on the back",
		],
		textFieldPlaceHolderAtThumbnailState: [
			.cardNumber: "Card No.",
			.holderName: "Name",
			.expiryDate: "MM/YY",
			.cvv: "CVV",
		],
		buttonTitleAtNormalState: [
			.addCard: "Add Card",
			.oneTimePayment: "Purchase",
		],
		buttonTitleAtDisabledState: [
			.addCard: "Add Card",
			.oneTimePayment: "Purchase",
		]
	)
}


extension IOTLanguageAndText {
	struct IOTLanguagePack {
		let textFieldPlaceHolder: [IOTTextFieldSubject: String]
		let textFieldPlaceHolderAtThumbnailState: [IOTTextFieldSubject: String]
		let buttonTitleAtNormalState: [IOTButtonSubject: String]
		let buttonTitleAtDisabledState: [IOTButtonSubject: String]
	}
}

//enum IOTLanguage: String {
//	case english
//
//	var pack: IOTLanguagePack {
//		switch self {
//		case .english:
//			return IOTLanguageAndText.english
//		default:
//			return IOTLanguageAndText.english
//		}
//	}
//}

enum IOTButtonSubject {
	case addCard
	case oneTimePayment
}
