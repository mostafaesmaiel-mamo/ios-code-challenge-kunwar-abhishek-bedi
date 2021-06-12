//
//  Configurations.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Alamofire

enum SessionManagerType {
	case `default`
	
	private var configuration: URLSessionConfiguration {
		URLSessionConfiguration.default
	}
	
	var sessionManager: Session {
		return Session(configuration: configuration)
	}
}
