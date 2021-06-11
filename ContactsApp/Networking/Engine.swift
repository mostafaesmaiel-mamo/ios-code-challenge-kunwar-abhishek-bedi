//
//  Engine.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Alamofire

struct NetworkEngine: Fetchable {
	
	fileprivate let manager: Session
	
	init(manager: Session) {
		self.manager = manager
	}
	
	func request<T: Resultable>(buildable: Buildable,
								type: T.Type,
								completion: @escaping (ServiceResult<T>) -> Void) {
		do {
			let request = try buildable.asURLRequest()
			fetch(request, completion: completion)
		} catch let exception {
			completion(.failure(ServiceError(error: exception.localizedDescription)))
		}
	}
}

fileprivate extension NetworkEngine {
	func fetch<T: Resultable>(_ request: URLRequest,
							  completion: @escaping (ServiceResult<T>) -> Void) {
		
		let dataRequest = manager.request(request).validate()
		fetch(dataRequest) { (data, response, error) in
			print(request)
			
			guard let responseData = data, response != nil else {
				completion(.failure(ServiceError(error: NetworkError.noData.value)))
				return
			}
			
			completion(T.result(responseData: responseData, response: response))
		}
	}
}
