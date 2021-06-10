//
//  UIView+Extension.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import UIKit

extension UIView {
    func roundCorners() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }
}
