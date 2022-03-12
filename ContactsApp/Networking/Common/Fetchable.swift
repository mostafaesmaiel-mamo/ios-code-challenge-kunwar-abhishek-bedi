//
//  Fetchable.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

protocol Fetchable {
	func fetch(_ dataRequest: URLRequest, completion: @escaping NetworkCompletion)
}
