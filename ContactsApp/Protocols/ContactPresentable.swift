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


/// Default Implementation for CollectionViewCells
extension ContactPresentable where Self: UICollectionViewCell {
	func setup(imageView: UIImageView, withContact contact: ContactProtocol) {
		if let data = contact.imageData, let image = UIImage(data: data) {
			imageView.image = image
		}
		else {
			imageView.setImageWith(contact.firstName, color: UIColor.random(), circular: true)
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

