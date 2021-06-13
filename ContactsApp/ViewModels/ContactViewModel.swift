//
//  ContactViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 13/06/2021.
//

struct ContactViewModel {
	private var contacts: [ContactProtocol] = []
	
	mutating func configure(withContacts contacts: [ContactProtocol]) {
		self.contacts = contacts
	}
}

extension ContactViewModel {
	
	func numberOfRow(inSection section: Int) -> Int {
		contacts.count
	}
	
	func contact(atIndex index: Int) -> Contact? {
		//TODO: - Need Safe Here
		contacts[index] as? Contact
	}
}

