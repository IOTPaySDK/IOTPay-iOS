//
//  HTTPNetWorkResponse.swift
//  NetworkManager
//
//  Created by macbook on 2021-04-15.
//

import Foundation

struct HTTPNetworkResponse {

		static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String>{

			guard let res = response else { return Result.failure(IOTHTTPNetworkError.unwrappingError)}

				switch res.statusCode {
					case 200...299: return Result.success("Successful Network Request")
				case 401: return Result.failure(IOTHTTPNetworkError.authenticationError)
				case 400...499: return Result.failure(IOTHTTPNetworkError.badRequest)
				case 500...599: return Result.failure(IOTHTTPNetworkError.serverSideError)
				default: return Result.failure(IOTHTTPNetworkError.failed)
				}
		}
}
