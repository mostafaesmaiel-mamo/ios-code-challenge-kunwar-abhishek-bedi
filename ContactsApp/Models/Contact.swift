//
//  Contact.swift
//  ContactsApp
//
//  Created by kbedi on 13/06/2021.
//

struct Contact: ContactProtocol {
	var id: String
	var firstName: String
	var lastName: String
	var phoneNumber: String?
	var email: String?
	var isMamoContact: Bool = false
	var isFrequentContact: Bool = false
}

