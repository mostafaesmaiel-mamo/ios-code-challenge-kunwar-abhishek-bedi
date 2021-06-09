//
//  AppColor.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

enum AppColor {
    
    case mamoBlue
    
    var value: UIColor? {
        switch self {
        case .mamoBlue: return UIColor(hex: "#3333FF")
        }
    }
    
}
