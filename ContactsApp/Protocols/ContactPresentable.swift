//
//  ContactPresentable.swift
//  ContactsApp
//
//  Created by kbedi on 15/06/2021.
//

import UIKit
import UIImageView_Letters

/// To present the contact on UI
protocol ContactPresentable {
	func configure(withContact contact: ContactProtocol)
}

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
