//
//  ContactProtocol.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//
/// To present the contact on UI
protocol ContactProtocol {
	var id: String {get}
	var firstName: String {get}
	var lastName: String {get}
	var phoneNumber: String? {get}
	var email: String? {get}
	var isMamoContact: Bool {get}
	var isFrequentContact: Bool {get}
	var publicName: String {get}
	var isDisplayable:Bool {get}
}

extension ContactProtocol {
	
	var publicName: String {
		firstName + " " + lastName
	}
	
	var isDisplayable: Bool {
		!publicName.trimmingCharacters(in: .whitespaces).isEmpty
	}
}
