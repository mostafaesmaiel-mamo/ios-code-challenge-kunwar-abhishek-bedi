//
//  WelcomeViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import Foundation
import SwiftyUserDefaults

struct WelcomeViewModel {
    let canShowPermissionPrimingAlert: Bool
    
    init(canShowPermissionPrimingAlert: Bool = Defaults[\.didUserGaveContactsPermission]) {
        self.canShowPermissionPrimingAlert = canShowPermissionPrimingAlert
    }
}
