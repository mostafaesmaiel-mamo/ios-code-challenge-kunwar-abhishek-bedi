//
//  NetworkManager.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

protocol NetworkAdaptor {
	func process<T: Resultable>(_ buildable: Buildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void)
}

struct NetworkManager: NetworkAdaptor {
	
	let engine: NetworkEngine
	
	init(type: SessionManagerType = .default) {
		engine = NetworkEngine(manager: type.sessionManager)
	}
	
	func process<T: Resultable>(_ buildable: Buildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void) {
		DispatchQueue.global(qos: .background).async {
			self.fetch(buildable: buildable, type: type, completion: completion)
		}
	}
	
	private func fetch<T: Resultable>(buildable: Buildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void) {
		engine.request(buildable: buildable, type: T.self) { (result) in
			DispatchQueue.main.async {
				completion(result)
			}
		}
	}
}
