//
//  Contact.swift
//  ContactsApp
//
//  Created by kbedi on 13/06/2021.
//
import Foundation

class Contact: ContactProtocol, Hashable {
	var id: String = ""
	var firstName: String = ""
	var lastName: String = ""
	var phoneNumbers: [String]?
	var emails: [String]?
	var imageData: Data?
	var isMamoContact: Bool = false
	var isFrequentContact: Bool = false

	var isSelected: Bool = false
	
	
	//MARK: - Hashable Conformance
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func == (lhs: Contact, rhs: Contact) -> Bool {
		lhs.id == rhs.id && lhs.publicName == rhs.publicName
	}
}

extension Contact {
	convenience init(id: String,
		 firstName: String,
		 lastName: String,
		 phoneNumbers: [String] = [],
		 emails: [String] = [],
		 imageData: Data? = nil,
		 isMamoContact: Bool = false,
		 isFrequentContact: Bool = false) {
		self.init()
		self.id = id
		self.firstName = firstName
		self.lastName = lastName
		self.phoneNumbers = phoneNumbers
		self.emails = emails
		self.imageData = imageData
		self.isMamoContact = isMamoContact
		self.isFrequentContact = isFrequentContact
	}
}

extension Contact {
	func toggleSelection() {
		isSelected = !isSelected
	}
}

extension Array where Self.Element: Contact {
	func contact(matchingEmail email: String) -> Contact? {
		let matchingContact = self.first(where: { contact in
			if let emails = contact.emails {
				return emails.contains(email)
			}
			return false
		})
		
		return matchingContact
	}
	
	func contact(matchingPhone phoneNumber: String) -> Contact? {
		let matchingContact = self.first(where: { contact in
			if let phoneNumbers = contact.phoneNumbers {
				return phoneNumbers.contains(phoneNumber)
			}
			return false
		})
		
		return matchingContact
	}
}

