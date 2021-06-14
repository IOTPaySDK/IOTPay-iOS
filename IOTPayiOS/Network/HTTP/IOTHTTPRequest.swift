//
//  File.swift
//  NetworkManager
//
//  Created by macbook on 2021-04-15.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct IOTHTTPNetworkRequest {

	static func configureHTTPRequest(from route: IOTHTTPNetworkRoute, with parameters: HTTPParameters, includes headers: HTTPHeaders, contains body: Data?, and method: IOTHTTPMethod) throws -> URLRequest {

		guard let url = URL(string: IOTNetworkRequest.apiPrefix + route.route) else {
			throw IOTHTTPNetworkError.missingURL
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
				try IOTURLEncoder.encodeParameters(for: &request, with: parameters)
				try IOTURLEncoder.setHeaders(for: &request, with: headers)
			}
		} catch {
			throw IOTHTTPNetworkError.encodingFailed
		}
	}
}
