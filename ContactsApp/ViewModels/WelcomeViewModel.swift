//
//  WelcomeViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//
import Contacts

struct WelcomeViewModel {
	private let defaults: MamoDefaults
	
	init(defaults: MamoDefaults = MamoDefaults.shared) {
		self.defaults = defaults
	}
	
	var shouldShowPermissionPrimingAlert: Bool {
		!defaults.canAccessContacts
	}
	
	var contactPermissionStatus: CNAuthorizationStatus {
		CNContactStore.authorizationStatus(for: .contacts)
	}

}
