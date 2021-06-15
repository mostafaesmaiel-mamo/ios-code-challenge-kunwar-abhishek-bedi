//
//  ChooseRecipientViewController+Contacts.swift
//  ContactsApp
//
//  Created by kbedi on 14/06/2021.
//

import Foundation

//MARK: - Contacts Related Functions -
extension ChooseRecipientViewController {
	
	func fetchPhoneContacts(onCompletion: @escaping (([Contact])-> Void)) {
		
		phoneContactManager.fetchPhoneContacts { result in
			onCompletion(result)
		}
	}
	
	func fetchMamoContacts(emails: [String], phones: [String], onCompletion: @escaping (([MamoAccount])-> Void)) {
		
		mamoContactManager.fetchSearchMamoContacts(emails: emails, orPhones: phones) { result in
			onCompletion(result)
		}
	}
	
	func fetchFrequentContacts(onCompletion: @escaping (([Frequent])-> Void)) {
		
		mamoContactManager.fetchFrequentMamoContacts { result in
			onCompletion(result)
		}
	}
}
