//
//  FrequentContactCell.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

protocol ContactPresentable {
    func configure(withFirstName firstName: String, lastName: String, imageUrl: String)
}

final class FrequentContactCell: UICollectionViewCell {

    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func reset() {
        firstNameLabel.text = nil
        lastNameLabel.text = nil
    }

}

extension FrequentContactCell: ContactPresentable {
    func configure(withFirstName firstName: String, lastName: String, imageUrl: String) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }
}
