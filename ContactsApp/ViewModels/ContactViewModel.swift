//
//  ContactViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 13/06/2021.
//
import Foundation

struct ContactViewModel {
	
	private var contacts: [ContactProtocol] = []
	
	mutating func configure(withContacts contacts: [ContactProtocol]) {
		self.contacts = contacts
	}
}


//MARK: - CollectionView Related Functions
extension ContactViewModel {
	
	func numberOfItems(inSection section: Int) -> Int {
		var count = 0
		if let section = Section(rawValue: section) { //TODO: - Need Safe Here
			switch section {
				case .frequentContacts: count = contacts.frequent.count
				case .mamoContacts: 	count = contacts.mamo.count
				case .phoneContacts: 	count = contacts.phone.count
			}
		}
		return count
	}
	
	func contact(atIndexPath indexPath: IndexPath) -> ContactProtocol? {
		
		var contact: ContactProtocol?
		//TODO: - Need Safe Here
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
fileprivate extension Sequence where Self.Element == ContactProtocol {
	
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
