//
//  ContactProtocol.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//
/// To present the contact on UI
import Foundation

protocol ContactProtocol {
	
    var id: String {get}
	var firstName: String {get}
	var lastName: String {get}
	var phoneNumbers: [String]? {get}
	var emails: [String]? {get}
	var imageData: Data? {get}
	var isMamoContact: Bool {get}
	var isFrequentContact: Bool {get}
	var publicName: String {get}
	var isDisplayable:Bool {get}
	
	var isSelected: Bool {get}
}

extension ContactProtocol {
	
	var publicName: String {
		firstName + " " + lastName
	}
	
	var isDisplayable: Bool {
		!publicName.trimmingCharacters(in: .whitespaces).isEmpty
	}
	
	var imageData: Data? {
		nil
	}
	
	var isSelected: Bool {
		false
	}
}
