//
//  Resultable.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

fileprivate extension String {
	static let unknown = "unknown"
}

enum ServiceResult<T: Codable> {
	case success(T)
	case failure(ServiceError)
}

protocol Resultable: Codable {
	func result() -> ServiceResult<Self>
	static func result<T: Resultable>(responseData: Data, response: HTTPURLResponse?) -> ServiceResult<T>
}

extension Resultable {
	func result() -> ServiceResult<Self> {
		return .success(self)
	}
	
	static func result<T: Resultable>(responseData: Data, response: HTTPURLResponse?) -> ServiceResult<T> {
		do {
			let object = try JSONDecoder().decode(T.self, from: responseData)
			return object.result()
		} catch let exception {
			print(exception)
			return .failure(ServiceError(error: exception.localizedDescription))
		}
	}
}



struct ServiceError: Error {
	let error: String
	
	init(error: String?) {
		self.error = error ?? .unknown
	}
}
