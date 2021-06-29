//
//  NSObject+Extension.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

extension NSObject {

    class var className: String? {
        return String(describing: self).components(separatedBy: ".").last
    }
    
    class var name: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: self.name, bundle: .main)
    }

}
