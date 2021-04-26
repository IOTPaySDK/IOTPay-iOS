//
//  HTTPResult.swift
//  IOTPay-iOS nonFramework
//
//  Created by macbook on 2021-04-16.
//

enum Result<T> {
		case success(T)
		case failure(Error)
//	var description: String {
//		switch self {
//			case .success(T): return ""
//			case .failure(Error): return ""
//		}
//	}
}
