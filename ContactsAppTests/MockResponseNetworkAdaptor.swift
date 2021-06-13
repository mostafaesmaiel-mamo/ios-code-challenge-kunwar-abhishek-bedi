//
//  MockResponseNetworkAdaptor.swift
//  ContactsAppTests
//
//  Created by kbedi on 13/06/2021.
//

import Foundation
@testable import ContactsApp

struct MockResponseNetworkAdaptor: NetworkAdaptor {
	
	let fileName: String
	let noFile = "We could not locate the file."
	
	func process<T: Resultable>(_ buildable: Buildable,
								type: T.Type,
								completion: @escaping (ServiceResult<T>) -> Void) {

		guard let data = try? JsonUtility.dataFromTestFile(named: fileName) else {
			completion(.failure(ServiceError(error: noFile)))
			return
		}
		
		let serviceResult = T.result(responseData: data, response: nil) as ServiceResult<T>
		switch serviceResult {
			case .success(let model):
				return completion(.success(model))
			case .failure(let error):
				completion(.failure(ServiceError(error: error.error)))
		}
	}
}
