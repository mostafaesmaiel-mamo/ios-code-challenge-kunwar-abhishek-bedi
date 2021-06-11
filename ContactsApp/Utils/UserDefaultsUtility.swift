//
//  UserDefaultsUtility.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import SwiftyUserDefaults

enum UserDefaultKey: StringLiteralType {
    case canAccessContacts
}

extension DefaultsKeys {
    var canAccessContacts: DefaultsKey<Bool> { .init(UserDefaultKey.canAccessContacts.rawValue, defaultValue: false) }
}

