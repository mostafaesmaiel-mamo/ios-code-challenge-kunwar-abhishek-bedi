//
//  ContactCell.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

final class ContactCell: UICollectionViewCell {
   
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var imageView: RoundedImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        firstNameLabel.text = nil
        lastNameLabel.text = nil
        imageView.image = nil
    }

}

extension ContactCell: ContactPresentable {
	func configure(withContact contact: ContactProtocol) {
		firstNameLabel.text = contact.firstName
		lastNameLabel.text = contact.lastName
		imageView.image = UIImage(named: "Vector")
	}
}
