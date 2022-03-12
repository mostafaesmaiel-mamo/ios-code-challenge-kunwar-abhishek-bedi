//
//  FrequentContactCell.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

final class FrequentContactCell: UICollectionViewCell {
    
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var imageView: RoundedImageView!
    @IBOutlet private weak var logoImageView: RoundedImageView!
    @IBOutlet private weak var bgView: UIView!
    
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

extension FrequentContactCell: ContactPresentable, BorderPresentable {
    
    func configure(with contact: ContactProtocol) {
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        imageView.setup(withContact: contact)
        contact.isSelected ? showBorder(onView: bgView) : hideBorder(onView: bgView)
    }
}
