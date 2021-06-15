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
	
	var hashValue: Int {
		get {
			return id.hashValue << 15
		}
	}
	
	static func == (lhs: Contact, rhs: Contact) -> Bool {
		lhs.id == rhs.id && lhs.publicName == rhs.publicName
	}
}

extension Contact {
	convenience init(id: String,
		 firstName: String,
		 lastName: String,
		 phoneNumbers: [String],
		 emails: [String],
		 imageData: Data?,
		 isMamoContact: Bool,
		 isFrequentContact: Bool) {
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

//extension Contact {
//	static func == (lhs: Contact, rhs: Contact) -> Bool {
//		lhs.id == rhs.id
//	}
//}

