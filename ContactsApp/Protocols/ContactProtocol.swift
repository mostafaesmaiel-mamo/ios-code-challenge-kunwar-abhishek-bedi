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
	func fetchContacts(onCompletion: @escaping ([CNContact]) -> ())
}

/// To present the contact on UI
protocol ContactPresentable {
    func configure(withFirstName firstName: String, lastName: String, imageUrl: String?)
}
