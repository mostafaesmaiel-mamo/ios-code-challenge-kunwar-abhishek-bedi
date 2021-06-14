//
//  ContactFetchable.swift
//  ContactsApp
//
//  Created by kbedi on 14/06/2021.
//

import ContactsUI

protocol ContactFetchable {}

/// To fetch contacts from Phone
protocol PhoneContactsFetchable: ContactFetchable {
	var store: CNContactStore { get }
	var keys: [String] { get }
	func fetchPhoneContacts(onCompletion: @escaping ([ContactProtocol]) -> ())
}

protocol MamoContactsFetchable: ContactFetchable {
	func fetchSearchMamoContacts(emails: [String], orPhones: [String], onCompletion: @escaping (ContactResult) -> ())
	func fetchFrequentMamoContacts(onCompletion: @escaping (ContactResult) -> ())
}


