//
//  ContactCell.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class ContactCell: UICollectionViewCell {
   
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
    
    func reset() {
        firstNameLabel.text = nil
        lastNameLabel.text = nil
        imageView.image = nil
    }

}

extension ContactCell: ContactPresentable {
    func configure(withFirstName firstName: String, lastName: String, imageUrl: String? = nil) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        imageView.image = UIImage(named: "Vector")
    }
}
