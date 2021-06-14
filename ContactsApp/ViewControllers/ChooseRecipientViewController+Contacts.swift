//
//  ChooseRecipientViewController+Contacts.swift
//  ContactsApp
//
//  Created by kbedi on 14/06/2021.
//

import Foundation

//MARK: - Contacts Related Functions -
extension ChooseRecipientViewController {
	
	func fetchPhoneContacts(onCompletion: @escaping (([ContactProtocol])-> Void)) {
		
		phoneContactManager.fetchPhoneContacts { phoneContacts in
			onCompletion(phoneContacts)
		}
	}
	
	func fetchMamoContacts(emails: [String], phones: [String], onCompletion: @escaping (([ContactProtocol])-> Void)) {
		mamoContactManager.fetchSearchMamoContacts(emails: emails, orPhones: phones) {[weak self] result in
			self?.processResult(result, onCompletion: onCompletion)
		}
	}
	
	func fetchFrequentContacts(onCompletion: @escaping (([ContactProtocol])-> Void)) {
		mamoContactManager.fetchFrequentMamoContacts {[weak self] result in
			self?.processResult(result, onCompletion: onCompletion)
		}
	}
}

fileprivate extension ChooseRecipientViewController {
	
	func processResult(_ result: ContactResult, onCompletion: @escaping (([ContactProtocol])-> Void)) {
		
		switch result {
			case .success(let accounts):
				print(accounts)
				
				onCompletion(accounts)
			case .failure(let error):
				print(error.error.description)
				onCompletion([])
		}
	}
}
