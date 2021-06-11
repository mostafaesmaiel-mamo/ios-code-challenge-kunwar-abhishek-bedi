//
//  Fetchable.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Alamofire

typealias NetworkCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

protocol Fetchable {
	func fetch(_ dataRequest: DataRequest, completion: @escaping NetworkCompletion)
}

extension Fetchable {
	
	func fetch(_ dataRequest: DataRequest, completion: @escaping NetworkCompletion) {
		dataRequest.responseString { responseString in
			completion(responseString.data, responseString.response, responseString.error)
		}
	}
}
