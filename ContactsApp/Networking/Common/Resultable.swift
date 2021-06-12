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

struct ServiceError: Error {
	let error: String
	
	init(error: String?) {
		self.error = error ?? .unknown
	}
}
