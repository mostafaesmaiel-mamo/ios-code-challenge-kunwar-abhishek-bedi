//
//  AppColor.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

enum AppColor {
    
    case cellSelectionBorderColor
    
    var value: UIColor? {
        switch self {
        case .cellSelectionBorderColor: return UIColor(hex: "#3333FF")
        }
    }
    
}
