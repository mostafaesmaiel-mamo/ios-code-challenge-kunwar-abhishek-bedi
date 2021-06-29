//
//  RoundedImageView.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//
 
import UIKit

class RoundedImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()        
        self.roundCorners()
        self.clipsToBounds = true
    }
}
