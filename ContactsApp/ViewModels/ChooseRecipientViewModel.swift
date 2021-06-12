//
//  ChooseRecipientViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

struct ChooseRecipientViewModel {
	let networkAdaptor: NetworkAdaptor
	
	init(networkAdaptor: NetworkAdaptor = NetworkManager()) {
		self.networkAdaptor = networkAdaptor
	}
	
	func fetchMamoContacts(emails: [String], orPhones: [String], onCompletion: @escaping ((Bool)-> Void) ) {
		let service = ContactsService.searchAccounts(emails: emails, orPhones: orPhones)
		networkAdaptor.process(service, type: MamoAccounts.self) { result in
			
			switch result {
				case .success(let response):
					if let accounts = response.mamoAccounts, !accounts.isEmpty {
						onCompletion(true)
					}
					
				case .failure(let error):
					onCompletion(false)
			}
		}
	}
	
}
