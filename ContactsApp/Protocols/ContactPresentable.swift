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
