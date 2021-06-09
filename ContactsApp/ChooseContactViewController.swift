//
//  ViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

enum Section {
    case frequentContacts
    case mamoContacts
    case phoneContacts
    
    var headerTitle: String {
        switch self {
        case .frequentContacts: return "Frequents"
        case .mamoContacts: return "Your Friends On Mamo"
        case .phoneContacts: return "Your Contacts"
        }
    }
}


class ChooseContactViewController: UICollectionViewController {
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "HeaderView"
    fileprivate let contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    var sections: [Section] = []

    //MARK:- View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections.append(.frequentContacts)
        sections.append(.mamoContacts)
        sections.append(.phoneContacts)

        setupCollectionView()
    }
}

//MARK:- UICollectionViewCallbacks
extension ChooseContactViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = indexPath.section == 0 ? .systemRed : .systemBlue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        let title = sections[indexPath.section].headerTitle
        header.configure(withTitle: title)
        return header
    }

}



private extension ChooseContactViewController {
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        //TODO: Remove Hardcoding
        collectionView.register(UINib.init(nibName: "HeaderView", bundle: .main), forSupplementaryViewOfKind: headerId, withReuseIdentifier: headerId)

        collectionView.collectionViewLayout = createLayout()
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            
            if section == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(107)))
                item.contentInsets.trailing = 22
                item.contentInsets.bottom = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = self.contentInsets

                section.orthogonalScrollingBehavior = .continuous
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: self.headerId, alignment: .topLeading)
                ]
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)))
                item.contentInsets.bottom = 16

                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = self.contentInsets
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: self.headerId, alignment: .topLeading)
                ]
                return section
            }
        }
    }
}
