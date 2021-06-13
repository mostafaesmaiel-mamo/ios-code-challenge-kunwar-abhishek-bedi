//
//  MamoAccounts.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

// MARK: - MamoAccounts
struct MamoAccounts: Resultable {
	let mamoAccounts: [MamoAccount]?
}

// MARK: - MamoAccount
struct MamoAccount: Codable {
	var mamoId: String?
	var key: Key?
	var value, publicName: String?
	
	enum CodingKeys: String, CodingKey {
		case key, value, publicName
		case mamoId = "id"
		
	}
}

enum Key: String, Codable {
	case email = "email"
	case phone = "phone"
}

extension MamoAccount {
	var mamoEmail: String? {
		key == .email ? value : ""
	}
	var mamoPhoneNumber: String? {
		key == .phone ? value : ""
	}
	
}

//MARK: - String Extension - Only Used Locally in this file
fileprivate extension String {
	var firstName: String? {
		self.components(separatedBy: " ").first
	}
	var lastName: String? {
		self.components(separatedBy: " ").last
	}
}

extension MamoAccount: ContactProtocol {
	var firstName: String {
		publicName?.firstName ?? ""
	}
	
	var lastName: String {
		publicName?.lastName ?? ""
	}
	
	var phoneNumber: String? {
		mamoPhoneNumber
	}
	
	var email: String? {
		mamoEmail
	}
	
	var isMamoContact: Bool {
		true
	}
	
	var isFrequentContact: Bool {
		false
	}
	
	var id: String {
		mamoId ?? ""
	}
	
}
