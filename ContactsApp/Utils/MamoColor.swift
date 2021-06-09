//
//  AppColor.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

enum MamoColor {
    
    case blue
    
    var value: UIColor? {
        switch self {
        case .blue: return UIColor(hex: "#3333FF")
        }
    }
    
}
