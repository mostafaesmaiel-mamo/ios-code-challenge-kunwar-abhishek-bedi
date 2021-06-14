//
//  ContactProtocol.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
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

/// To present the contact on UI
protocol ContactProtocol {
	var id: String {get}
	var firstName: String {get}
	var lastName: String {get}
	var phoneNumber: String? {get}
	var email: String? {get}
	var isMamoContact: Bool {get}
	var isFrequentContact: Bool {get}
	var publicName: String {get}
	var isDisplayable:Bool {get}
}

extension ContactProtocol {	
	var publicName: String {
		firstName + " " + lastName
	}
	var isDisplayable: Bool {
		!publicName.trimmingCharacters(in: .whitespaces).isEmpty //&& publicName != " "
	}
}

extension Sequence where Self.Element == ContactProtocol {
	var filteredEmails: [String] {
		self.compactMap { contact in
			if let email = contact.email, !email.isEmpty {
				return email
			}
			return nil
		}
	}
}

extension Sequence where Self.Element == ContactProtocol {
	
	var frequent: [ContactProtocol] {
		self.filter({$0.isFrequentContact && $0.isDisplayable })
	}
	
	var mamo: [ContactProtocol] {
		self.filter({ $0.isMamoContact && $0.isDisplayable })
					+ self.filter({ $0.isFrequentContact && $0.isDisplayable})
	}
	
	var phone: [ContactProtocol] {
		self.filter({ !$0.isMamoContact && !$0.isFrequentContact && $0.isDisplayable})
	}
}



/// To present the contact on UI
protocol ContactPresentable {
	func configure(withContact contact: ContactProtocol)
}

