//
//  WelcomeViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import Foundation
import SwiftyUserDefaults

struct WelcomeViewModel {
    var canShowPermissionPrimingAlert: Bool {
        didSet {
            Defaults[\.didUserGaveContactsPermission] = canShowPermissionPrimingAlert
        }
    }
    
    init(canShowPermissionPrimingAlert: Bool = Defaults[\.didUserGaveContactsPermission]) {
        self.canShowPermissionPrimingAlert = canShowPermissionPrimingAlert
    }
    
    mutating func updateShowPermissionPrimingAlert(shouldShowAgain: Bool) {
        self.canShowPermissionPrimingAlert = shouldShowAgain
    }
}
