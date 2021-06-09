//
//  ViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class ChooseContactViewController: UICollectionViewController {
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "HeaderView"
    fileprivate let sectionContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    var sections: [Section] = []

    //MARK:- View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSections()
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
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView {
            let title = sections[indexPath.section].headerTitle
            header.configure(withTitle: title)
            return header
        }
        
        return UICollectionReusableView()
    }
}


private extension ChooseContactViewController {
    
    func setupSections() {
        sections.append(.frequentContacts)
        sections.append(.mamoContacts)
        sections.append(.phoneContacts)
    }
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        //TODO: Remove Hardcoding
        collectionView.register(UINib.init(nibName: "HeaderView", bundle: .main), forSupplementaryViewOfKind: headerId, withReuseIdentifier: headerId)

        collectionView.collectionViewLayout = createLayout()
    }
    
    func frequentContactsSection(contentInset: NSDirectionalEdgeInsets,
                                             headerId: String) -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(107)))
        item.contentInsets.trailing = 22
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = contentInset
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            self.headerSupplementaryView
        ]

        return section
    }
    
    func otherContactsSection(contentInset: NSDirectionalEdgeInsets,
                                          headerId: String) -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)))
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionContentInsets
        section.boundarySupplementaryItems = [
            self.headerSupplementaryView
        ]
        return section
    }
    
    var headerSupplementaryView: NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerId, alignment: .topLeading)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (section, env) -> NSCollectionLayoutSection? in
            
            guard let self = self else { return nil }
            
            let contactSection = self.sections[section]
            
            switch contactSection {
            case .frequentContacts:
                return self.frequentContactsSection(contentInset: self.sectionContentInsets, headerId: self.headerId)
                
            case .mamoContacts, .phoneContacts:
                return self.otherContactsSection(contentInset: self.sectionContentInsets, headerId: self.headerId)
            }
        }
    }
}
