//
//  File.swift
//  NetworkManager
//
//  Created by macbook on 2021-04-15.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {

	static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters, includes headers: HTTPHeaders, contains body: Data?, and method: HTTPMethod) throws -> URLRequest {

		guard let url = URL(string: "https://ccapi.iotpaycloud.com/v3/" + route.rawValue) else {
			throw HTTPNetworkError.missingURL
		}
			var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData,
															 timeoutInterval: 10.0)

			request.httpMethod = method.rawValue
			request.httpBody = body
			try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)

			return request
	}

	static func configureParametersAndHeaders(parameters: HTTPParameters?,
																		 headers: HTTPHeaders?,
																		 request: inout URLRequest) throws {

		do {
			if let headers = headers, let parameters = parameters {
				try URLEncoder.encodeParameters(for: &request, with: parameters)
				try URLEncoder.setHeaders(for: &request, with: headers)
			}
		} catch {
			throw HTTPNetworkError.encodingFailed
		}
	}
}
