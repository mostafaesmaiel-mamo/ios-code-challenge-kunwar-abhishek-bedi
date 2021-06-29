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
	
    let mamoId, frequentPublicName: String?
	
	enum CodingKeys: String, CodingKey {
		case mamoId = "id"
		case frequentPublicName = "publicName"
	}
}

extension Frequent: ContactProtocol {
	
	var id: String {
		mamoId ?? ""
	}
	
	var firstName: String {
		frequentPublicName?.components(separatedBy: " ").first ?? ""
	}
	
	var lastName: String {
		frequentPublicName?.components(separatedBy: " ").last ?? ""
	}
	
	var phoneNumbers: [String]? {
		nil
	}
	
	var emails: [String]? {
		nil
	}
	
	var isMamoContact: Bool {
		false
	}
	
	var isFrequentContact: Bool {
		true
	}
}
