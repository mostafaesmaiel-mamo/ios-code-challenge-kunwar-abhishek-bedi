//
//  Section.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import Foundation

enum Section {
    case frequentContacts
    case mamoContacts
    case phoneContacts
    
    var headerTitle: String {
        switch self {
        case .frequentContacts: return "Frequents"
        case .mamoContacts: return "Your Friends On Mamo"
        case .phoneContacts: return "Your Contacts"
        }
    }
}

