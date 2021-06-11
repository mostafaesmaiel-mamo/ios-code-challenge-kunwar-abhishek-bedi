//
//  ContactsManager.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//
import ContactsUI

struct ContactsManager: PhoneContactsFetchable {
	
	var store: CNContactStore = CNContactStore()
	var keys: [String] = [CNContactPhoneNumbersKey]
	
	func fetchContacts(onCompletion: @escaping (Bool) -> ()) {
		
		let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
		do {
			try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer)
				in
				print(contact.description)
				onCompletion(true)
			})
		} catch let error {
			print("Failed to enumerate contact", error)
			onCompletion(false)
		}
	}
}
