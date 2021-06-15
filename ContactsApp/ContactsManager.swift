//
//  ContactsManager.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//
import ContactsUI

enum ContactResult {
	case success([ContactProtocol])
	case failure(ServiceError)
}

class ContactsManager {
	let networkAdaptor: NetworkAdaptor
	
	init(networkAdaptor: NetworkAdaptor = NetworkManager()) {
		self.networkAdaptor = networkAdaptor
	}
}

extension ContactsManager: PhoneContactsFetchable {
	
	var store: CNContactStore { CNContactStore() }
	
	var keys: [String] {
		[CNContactGivenNameKey,
						  CNContactFamilyNameKey,
						  CNContactImageDataKey,
						  CNContactThumbnailImageDataKey,
						  CNContactImageDataKey,
						  CNContactImageDataAvailableKey,
						  CNContactPhoneNumbersKey,
						  CNContactEmailAddressesKey]
	}
	
	func fetchPhoneContacts(onCompletion: @escaping ([Contact]) -> ()) {
		var fetchedContacts: [Contact] = []
		let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
		do {
			try store.enumerateContacts(with: request, usingBlock: {(contact, stopPointer)
				in
				print(contact.transform())
				fetchedContacts.append(contact.transform())
//				print(contact.description)
			})
		} catch let error {
			print("Failed to enumerate contact", error)
			onCompletion([])
		}
		onCompletion(fetchedContacts)

	}
}

//MARK: - Mamo Contacts API
extension ContactsManager: MamoContactsFetchable {
	func fetchFrequentMamoContacts(onCompletion: @escaping ([Frequent]) -> ()) {
		let service = ContactsService.frequentAccounts
		networkAdaptor.process(service, type: FrequentContact.self) { result in
			
			switch result {
				case .success(let response):
					if let accounts = response.frequents, !accounts.isEmpty {
						onCompletion(accounts)
					}
					
				case .failure:
					onCompletion([])
			}
		}
	}
	
	
	func fetchSearchMamoContacts(emails: [String], orPhones: [String], onCompletion: @escaping ([MamoAccount]) -> ()) {
		let service = ContactsService.searchAccounts(emails: emails, orPhones: orPhones)
		networkAdaptor.process(service, type: MamoAccounts.self) { result in
			
			
			switch result {
				case .success(let response):
					if let accounts = response.mamoAccounts, !accounts.isEmpty {
						onCompletion(accounts)
					}
					
				case .failure:
					onCompletion([])
			}
		}
	}
}


//MARK: - Other Useful Extensions
fileprivate extension CNContact {
	
	func transform() -> Contact {
		ContactBridge.transform(type: self)
	}
}

fileprivate struct ContactBridge {
	static func transform(type: CNContact) -> Contact {
		
		return Contact(id: type.identifier,
							  firstName: type.givenName,
							  lastName: type.familyName,
							  phoneNumbers: type.phoneNumbers.compactMap({ $0.value.stringValue }),
							  emails: type.emailAddresses.compactMap({ $0.value as String? }),
							  imageData: type.thumbnailImageData,
							  isMamoContact: false, isFrequentContact: false)
	}
}
