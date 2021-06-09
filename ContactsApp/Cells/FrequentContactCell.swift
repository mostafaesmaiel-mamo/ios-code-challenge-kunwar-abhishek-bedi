//
//  FrequentContactCell.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class FrequentContactCell: UICollectionViewCell {

    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var imageView: RoundedImageView!
    @IBOutlet private weak var bgView: UIView!

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
    
    func showBorder() {
        bgView.layer.borderWidth = 4.0
        bgView.layer.borderColor = MamoColor.blue.value?.cgColor
        layoutIfNeeded()
    }

    func hideBorder() {
        bgView.layer.borderWidth = 0.0
        bgView.layer.borderColor = UIColor.clear.cgColor
        layoutIfNeeded()
    }
    
}

extension FrequentContactCell: ContactPresentable {
    func configure(withFirstName firstName: String, lastName: String, imageUrl: String? = nil) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        imageView.image = UIImage(named: "bg")
    }
}
