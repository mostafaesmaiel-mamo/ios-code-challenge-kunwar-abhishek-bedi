//
//  Buildable.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation
import Alamofire

typealias Params = [String: Any]
typealias Headers = [String: String]

enum Encoding {
	case json
	case url
}

enum HTTPMethodType: String {
	case get = "GET"
	case post = "POST"
}

protocol Buildable {
	
	// MARK: - Properties
	var url: URL? { get }
	var headers: Headers { get }
	var params: Params? { get }
	var encoding: Encoding { get }
	var method: HTTPMethodType { get }
}

extension Buildable {
	
	private var httpMethod: HTTPMethodType {
		return method
	}
		
	private var parameterEncoding: ParameterEncoding {
		switch encoding {
			case .json:
				return JSONEncoding.default
			case .url:
				return URLEncoding.default
		}
	}
	
	var encoding: Encoding {
		return .url
	}
	
	var method: HTTPMethodType {
		return .get
	}
	
	var params: Params? {
		return nil
	}
	
	var headers: Headers {
		return [:]
	}
	
	func asURLRequest() throws -> URLRequest {
		guard let formedURL = url else {
			throw URLError.urlMalformatted
		}
		
		var request = URLRequest(url: formedURL)
		request.httpMethod = httpMethod.rawValue
		request.allHTTPHeaderFields = headers
		do {
			return try parameterEncoding.encode(request, with: params)
		} catch {
			throw URLRequestError.encodingFailed
		}
	}
}
