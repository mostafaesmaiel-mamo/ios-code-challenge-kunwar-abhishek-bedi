//
//  ContactsService.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

enum ContactsService: Buildable {

	case searchAccounts(emails: [String], orPhones: [String])
	case frequentAccounts

	var url: URL? {
		let baseUrl = AppConstants.baseUrl
		var relativePath: String?
		switch self {
			case .searchAccounts:
				relativePath = "api/v2/accounts"
			case .frequentAccounts:
				relativePath = "api/v2/frequents"
		}
		
		if let relativePath = relativePath {
			return URL(string: "\(baseUrl)\(relativePath)")
		}
		return nil
	}
	
	var params: Params? {
		switch self {
			case .searchAccounts(let emails, let phones):
				return ["emails": emails,
						"phones": phones]
			
			case .frequentAccounts:
				return nil
		}
	}
	
	var method: HTTPMethodType {
		switch self {
			case .searchAccounts: return .post
			case .frequentAccounts: return .get
		}
	}
	
	var encoding: Encoding {
		switch self {
			case .searchAccounts: return .json
			case .frequentAccounts: return .url
		}
	}
	
}
