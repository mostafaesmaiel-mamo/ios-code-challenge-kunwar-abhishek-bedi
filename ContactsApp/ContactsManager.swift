//
//  ContactsManager.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//
import ContactsUI

struct ContactsManager: PhoneContactsFetchable {

	var store: CNContactStore = CNContactStore()
	var keys: [String] = [CNContactGivenNameKey,
						  CNContactFamilyNameKey,
						  CNContactImageDataKey,
						  CNContactThumbnailImageDataKey,
						  CNContactPhoneNumbersKey,
						  CNContactEmailAddressesKey]
	
	func fetchContacts(onCompletion: @escaping ([CNContact]) -> ()) {
		var fetchedContacts: [CNContact] = []
		let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
		do {
			try store.enumerateContacts(with: request, usingBlock: {(contact, stopPointer)
				in
				fetchedContacts.append(contact)
				print(contact.description)
				onCompletion(fetchedContacts)
			})
		} catch let error {
			print("Failed to enumerate contact", error)
			onCompletion([])
		}
	}
}
