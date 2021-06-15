//
//  AppColor.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

enum MamoColor {
    
    case blue
	case gray
	case grayBackground

    var value: UIColor? {
        switch self {
			case .blue: return UIColor(hex: "#3333FF")
			case .gray: return UIColor(hex: "#C7D1DC")
			case .grayBackground: return UIColor(hex: "#F3F5F9")
        }
		
    }
    
}
