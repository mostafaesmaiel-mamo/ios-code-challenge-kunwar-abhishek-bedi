//
//  NetworkErrors.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//
import Foundation

/// Errors
fileprivate extension String {
	static let invalidURL = "URL is not valid"
	static let unableToDecode = "We could not decode the response."
	static let dataUnavailable = "Response returned with no data to decode."
	static let noNetwork = "No Network"
}


fileprivate extension Int {
	static let dataUnavailable = 8910
	static let noNetwork = 8911
	static let unableToDecode = 8912
}



/// Network error networking
enum NetworkError: Error {
	case noData
	case noNetwork
	case unableToDecode
	
	var value: String {
		switch self {
			case .noData: return .dataUnavailable
			case .noNetwork: return .noNetwork
			case .unableToDecode: return .unableToDecode
		}
	}
	
	var errorCode: Int {
		switch self {
			case .noData: return .dataUnavailable
			case .noNetwork: return .noNetwork
			case .unableToDecode: return .unableToDecode
		}
	}
}

enum URLError: Error {
	case urlMalformatted
	
	var value: String {
		switch self {
			case .urlMalformatted: return .invalidURL
		}
	}
}

enum URLRequestError: Error {
	case encodingFailed
	
	var value: String {
		switch self {
			case .encodingFailed: return .unableToDecode
		}
	}
}

