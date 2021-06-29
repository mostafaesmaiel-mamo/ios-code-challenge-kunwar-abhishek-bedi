//
//  BorderPresentable.swift
//  ContactsApp
//
//  Created by kbedi on 16/06/2021.
//
import UIKit

protocol BorderPresentable {
	
    func showBorder(onView view: UIView)
	func hideBorder(onView view: UIView)
}

extension BorderPresentable where Self: UIView {
	
    func showBorder(onView view: UIView) {
		view.layer.borderWidth = 4.0
		view.layer.borderColor = MamoColor.blue.value?.cgColor
		layoutIfNeeded()
		
	}
	
    func hideBorder(onView view: UIView) {
		view.layer.borderWidth = 0.0
		view.layer.borderColor = UIColor.clear.cgColor
		layoutIfNeeded()
	}
}

