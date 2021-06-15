//
//  UIImageView+Extension.swift
//  ContactsApp
//
//  Created by kbedi on 15/06/2021.
//

import Foundation
import UIImageView_Letters

extension UIImageView {
	func setup(withContact contact: ContactProtocol) {
		if let data = contact.imageData, let image = UIImage(data: data) {
			self.image = image
		}
		else {
			// Use a fixed color here if needed.
			self.setImageWith(contact.firstName, color: UIColor.random(), circular: true)
		}
	}
}


fileprivate extension UIColor {
	class func random(randomAlpha: Bool = false) -> UIColor {
		let redValue = CGFloat(arc4random_uniform(255)) / 255.0;
		let greenValue = CGFloat(arc4random_uniform(255)) / 255.0;
		let blueValue = CGFloat(arc4random_uniform(255)) / 255.0;
		let alphaValue = randomAlpha ? CGFloat(arc4random_uniform(255)) / 255.0 : 1;
		
		return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
	}
}

