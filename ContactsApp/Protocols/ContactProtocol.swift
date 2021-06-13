//
//  ContactProtocol.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//
import ContactsUI

/// To fetch contacts from Phone
protocol PhoneContactsFetchable {
	var store: CNContactStore { get set }
	var keys: [String] { get set }
	func fetchPhoneContacts(onCompletion: @escaping ([ContactProtocol]) -> ())
}

/// To present the contact on UI
protocol ContactProtocol {
	var id: String {get set}
	var firstName: String {get set}
	var lastName: String {get set}
	var phoneNumber: String? {get set}
	var email: String? {get set}
	var isMamoContact: Bool {get set}
	var isFrequentContact: Bool {get set}
}

/// To present the contact on UI
protocol ContactPresentable {
	func configure(withContact contact: ContactProtocol)
}

