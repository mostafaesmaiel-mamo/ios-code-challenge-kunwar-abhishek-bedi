//
//  UserDefaultsUtility.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import Foundation
import SwiftyUserDefaults

enum UserDefaultKey: StringLiteralType {
    case didUserGaveContactsPermission
}

extension DefaultsKeys {
    var didUserGaveContactsPermission: DefaultsKey<Bool> { .init(UserDefaultKey.didUserGaveContactsPermission.rawValue, defaultValue: false) }
}
