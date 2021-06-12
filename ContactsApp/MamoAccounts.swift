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
	let id: String?
	let key: Key?
	let value, publicName: String?
}

enum Key: String, Codable {
	case email = "email"
	case phone = "phone"
}
