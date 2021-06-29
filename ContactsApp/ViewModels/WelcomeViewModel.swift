//
//  WelcomeViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//
import Contacts

struct WelcomeViewModel {
	
	var contactPermissionStatus: CNAuthorizationStatus {
		CNContactStore.authorizationStatus(for: .contacts)
	}
}
