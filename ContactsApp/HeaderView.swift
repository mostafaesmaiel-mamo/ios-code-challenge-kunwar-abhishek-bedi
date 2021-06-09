//
//  HeaderView.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
     @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(withTitle title: String) {
        titleLabel.text = title
    }
}
