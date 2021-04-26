//
//  IOTOutputFormatter.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-08.
//

import Foundation

final class IOTOutputFormatModel {

	init() {}

	func formatting(text: String, for textFieldType: IOTTextFieldSubject) -> String {
		switch textFieldType {
		case .holderName: return holderName(text: text)
		case .cardNumber: return cardNumber(text: text)
		case .expiryDate: return expiryDate(text: text)
		case .cvv: return cvv(text: text)
		}
	}

	private func holderName(text: String) -> String {
		return text.capitalized
	}

	private func cardNumber(text: String) -> String {
		var counter = 0
		var result = ""
		for char in text {
			result += String(char)
			counter += 1
			if counter == 4 {
				counter = 0
				result += " "
			}
		}
		
		return result
	}


//		var arrWithOneForwardSlash = [Character]()
//		var isForwardSlashAppeared = false
//		for char in charArr {
//			if char == "/" {
//				if isForwardSlashAppeared {
//					break
//				} else {
//					isForwardSlashAppeared = true
//				}
//			}
//			arrWithOneForwardSlash.append(char)
//		}
	private func expiryDate(text: String) -> String {
		var arrWithOneForwardSlash = Array(text)
		guard !arrWithOneForwardSlash.isEmpty, arrWithOneForwardSlash[0] != "/" else { return "" }
		switch arrWithOneForwardSlash.count {
			case 0:
				break
			case 1:
				if let firstInt = Int(String(arrWithOneForwardSlash[0])),  firstInt > 1 {
					arrWithOneForwardSlash.insert("0", at: 0)
					arrWithOneForwardSlash.append("/")
				}
			case 2:
				if arrWithOneForwardSlash[1] == "/" {
					arrWithOneForwardSlash.insert("0", at: 0)
					break
				}
				if let firstInt = Int(String(arrWithOneForwardSlash[0])),
					 let secondInt = Int(String(arrWithOneForwardSlash[1])) { // 2 int, add slash
					if firstInt * 10 + secondInt <= 12 {
						arrWithOneForwardSlash.append("/")
					} else {
						// is wrong
					}
				}
			case 3:
				if arrWithOneForwardSlash[1] == "/" {
					arrWithOneForwardSlash.insert("0", at: 0)
				}
				if arrWithOneForwardSlash[2] == "/" { break }
				if Int(String(arrWithOneForwardSlash[2])) != nil {
					arrWithOneForwardSlash.insert("/", at: 2)
				}
			case 4:
				if arrWithOneForwardSlash[1] == "/" {
					arrWithOneForwardSlash.insert("0", at: 0)
				}
				if arrWithOneForwardSlash[2] == "/" { break }
				if arrWithOneForwardSlash[3] == "/" {
					arrWithOneForwardSlash.remove(at: 2)
				}
			case 5:
				if arrWithOneForwardSlash[1] == "/" {
					arrWithOneForwardSlash.insert("0", at: 0)
				}
				if arrWithOneForwardSlash[2] == "/" { break }
				if arrWithOneForwardSlash[3] == "/" {
					arrWithOneForwardSlash.remove(at: 2)
				}
				if arrWithOneForwardSlash[4] == "/" {
					arrWithOneForwardSlash.remove(at: 2)
					arrWithOneForwardSlash.remove(at: 2)
				}
			default: break
		}


		let str = String(arrWithOneForwardSlash)

		return str
	}

	private func cvv(text: String) -> String {

		return text
	}

}
