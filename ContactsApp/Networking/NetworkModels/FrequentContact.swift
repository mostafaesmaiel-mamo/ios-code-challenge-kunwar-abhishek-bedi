//
//  FrequentContact.swift
//  ContactsApp
//
//  Created by kbedi on 14/06/2021.
//

import Foundation

// MARK: - FrequentContact
struct FrequentContact: Resultable {
	let frequents: [Frequent]?
}

// MARK: - Frequent
struct Frequent: Codable {
	let mamoId, publicName: String?
	
	enum CodingKeys: String, CodingKey {
		case publicName
		case mamoId = "id"
	}
}

extension Frequent: ContactProtocol {
	var id: String {
		mamoId ?? ""
	}
	
	var firstName: String {
		publicName.components(separatedBy: " ").first ?? ""
	}
	
	var lastName: String {
		publicName.components(separatedBy: " ").last ?? ""
	}
	
	var phoneNumber: String? {
		nil
	}
	
	var email: String? {
		nil
	}
	
	var isMamoContact: Bool {
		false
	}
	
	var isFrequentContact: Bool {
		true
	}
	
	
}
