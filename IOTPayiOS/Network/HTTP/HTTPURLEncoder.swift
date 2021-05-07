//
//  URLEncoder.swift
//  NetworkManager
//
//  Created by macbook on 2021-04-15.
//


import Foundation

public struct URLEncoder {

	static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
		if parameters == nil { return }
		guard let url = urlRequest.url, let unwrappedParameters = parameters else { throw HTTPNetworkError.missingURL }

		if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !unwrappedParameters.isEmpty {
			urlComponents.queryItems = [URLQueryItem]()
			for (key,value) in unwrappedParameters {
				let queryItem = URLQueryItem(name: key, value: "\(value)")
				urlComponents.queryItems?.append(queryItem)
			}
			urlRequest.url = urlComponents.url
		}
	}

	static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {

		if headers == nil { return }
		guard let unwrappedHeaders = headers else { throw HTTPNetworkError.headersNil }
		for (key, value) in unwrappedHeaders{
			urlRequest.setValue(value as? String, forHTTPHeaderField: key)
		}
	}
}
