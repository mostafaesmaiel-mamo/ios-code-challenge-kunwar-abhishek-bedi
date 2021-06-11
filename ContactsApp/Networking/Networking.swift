//
//  Networking.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

protocol Networking {
	
	/// Performs the specified request.
	/// - Parameter request: The request to perform.
	/// - Parameter completion: Closure called upon success or failure.
	func performRequest<T: Decodable>(_ request: Request, completion: @escaping (Result<T, NetworkError>) -> Void)
}
