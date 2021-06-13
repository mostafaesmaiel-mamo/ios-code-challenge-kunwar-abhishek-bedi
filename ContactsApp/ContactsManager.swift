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
						  CNContactImageDataKey,
						  CNContactImageDataAvailableKey,
						  CNContactPhoneNumbersKey,
						  CNContactEmailAddressesKey]
	
	func fetchPhoneContacts(onCompletion: @escaping ([ContactProtocol]) -> ()) {
		var fetchedContacts: [ContactProtocol] = []
		let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
		do {
			try store.enumerateContacts(with: request, usingBlock: {(contact, stopPointer)
				in

				if contact.imageDataAvailable {
					print(contact.givenName)
				}
				
				fetchedContacts.append(contact.transform())
//				print(contact.description)
				onCompletion(fetchedContacts)
			})
		} catch let error {
			print("Failed to enumerate contact", error)
			onCompletion([])
		}
	}
}

extension CNContact {
	
	func transform() -> ContactProtocol {
		ContactBridge.transform(type: self)
	}
}

struct ContactBridge {
	static func transform(type: CNContact) -> ContactProtocol {
		return Contact(id: type.identifier,
							  firstName: type.givenName,
							  lastName: type.familyName,
							  phoneNumber: type.phoneNumbers.first?.value.stringValue,
							  email: "", //TODO: - Need to fix this
							  isMamoContact: false, isFrequentContact: false)
	}
}
