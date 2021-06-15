//
//  ContactViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 13/06/2021.
//
import Foundation

struct ContactViewModel {
	
	private(set) var contacts: [Contact] = []
	
	mutating func configure(withPhoneContacts phoneContacts: [Contact],
							mamoContacts: [MamoAccount],
							frequentContacts: [Frequent]) {
		self.contacts = processContacts(phoneContacts, mamoContacts, frequentContacts)
	}
	
	private mutating func processContacts(_ phoneContacts: [Contact],
								 _ mamoContacts: [MamoAccount],
								 _ frequentContacts: [Frequent]) -> [Contact]{
		
		var contacts:[Contact] = []
		
		for phone in phoneContacts {
			var didAddContact = false
			for mamo in mamoContacts {
				
				if mamo.mamoPublicName == phone.publicName {
					var pc = phone
					pc.isMamoContact = true
					contacts.append(pc)
					didAddContact = true
				}
				else if let phoneEmails = phone.emails, phoneEmails.contains(mamo.value ?? "") {
					var pc = phone
					pc.isMamoContact = true
					contacts.append(pc)
					didAddContact = true
				}
				else if let phoneNumbers = phone.phoneNumbers, phoneNumbers.contains(mamo.value ?? "") {
					var pc = phone
					pc.isMamoContact = true
					contacts.append(pc)
					didAddContact = true
				}
			}

			if !didAddContact {
				contacts.append(phone)
			}
	
		}
		
		// Frequent Contact Updates
		for freq in frequentContacts {
			
			if var pc = phoneContacts.first(where: { $0.firstName == freq.firstName }) {
				pc.isFrequentContact = true
				contacts.append(pc)
			}
		}
		
		return Array(Set(contacts)) //contacts
	}
}


//MARK: - CollectionView Related Functions
extension ContactViewModel {
	
	func numberOfItems(inSection section: Int) -> Int {
		var count = 0
		if let section = Section(rawValue: section) {
			switch section {
				case .frequentContacts: count = contacts.frequent.count
				case .mamoContacts: 	count = contacts.mamo.count
				case .phoneContacts: 	count = contacts.phone.count
			}
		}
		return count
	}
	
	func contact(atIndexPath indexPath: IndexPath) -> Contact? {
		
		var contact: Contact?
		if let section = Section(rawValue: indexPath.section) {
			switch section {
				case .frequentContacts: contact = contacts.frequent[indexPath.row]
				case .mamoContacts: contact = contacts.mamo[indexPath.row]
				case .phoneContacts: contact = contacts.phone[indexPath.row]
			}
		}
		
		return contact
	}
}

//MARK: - Private Extensions
fileprivate extension Sequence where Self.Element == Contact {
	
	var frequent: [Contact] {
		self.filter({$0.isFrequentContact && $0.isDisplayable })
	}
	
	var mamo: [Contact] {
		self.filter({ $0.isMamoContact && $0.isDisplayable })
			+ self.filter({ $0.isFrequentContact && $0.isDisplayable})
	}
	
	var phone: [Contact] {
		self.filter({ !$0.isMamoContact && !$0.isFrequentContact && $0.isDisplayable})
	}
}
