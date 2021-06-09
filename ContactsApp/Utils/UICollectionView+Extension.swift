//
//  UICollectionView+Extension.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type, bundle: Bundle? = nil) {
        if let className = cellType.className {
            let nib = UINib(nibName: className, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: className)
        }
    }
    
    func registerNibs<T: UICollectionViewCell>(_ cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { registerNib($0, bundle: bundle) }
    }

}
