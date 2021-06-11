//
//  MamoDefaults.swift
//  ContactsApp
//
//  Created by kbedi on 11/06/2021.
//

import SwiftyUserDefaults

class MamoDefaults: UserDefaults {
	static let shared = MamoDefaults()
}

extension MamoDefaults {
	
	var canAccessContacts: Bool {
		set {
			Defaults[\.canAccessContacts] = newValue
		} get {
			return Defaults[\.canAccessContacts]
		}
	}
}
