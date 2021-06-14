//
//  ViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {

	private var viewModel: ContactViewModel = ContactViewModel()
	
    fileprivate let sectionContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    var sections: [Section] = []

    //MARK:- View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSections()
        setupCollectionView()
    }
	
	func configure(withContacts contacts:[ContactProtocol]) {
		viewModel.configure(withContacts: contacts)
	}
}

//MARK:- UICollectionViewCallbacks
extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.numberOfItems(inSection: section)
    }
    
    func frequentContactCell(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> FrequentContactCell? {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FrequentContactCell.name, for: indexPath) as? FrequentContactCell else {
            fatalError("FrequentContactCell cannot be nil")
        }
        
        return cell
    }

    func otherContactCell(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> ContactCell? {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.name, for: indexPath) as? ContactCell else {
            fatalError("ContactCell cannot be nil")
        }
        
        return cell
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let contact = viewModel.contact(atIndexPath: indexPath) else {
			return UICollectionViewCell()
		}
		
        let section = sections[indexPath.section]

		switch section {
			case .frequentContacts:
				
				if let cell = frequentContactCell(collectionView, forIndexPath: indexPath) {
					cell.configure(withContact: contact)
					return cell
				}
				
			case .mamoContacts:
				
				if let cell = otherContactCell(collectionView, forIndexPath: indexPath) {
					cell.configure(withContact: contact)
					return cell
				}
				
			case .phoneContacts:
				if let cell = otherContactCell(collectionView, forIndexPath: indexPath) {
					cell.configure(withContact: contact)
					return cell
				}
		}

		return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.name, for: indexPath) as? HeaderView {
            let title = sections[indexPath.section].headerTitle
            header.configure(withTitle: title)
            return header
        }
        
        return UICollectionReusableView()
    }
}

private extension CollectionViewController {
    	
    func setupSections() {
        sections.append(.frequentContacts)
        sections.append(.mamoContacts)
        sections.append(.phoneContacts)
    }
    
    func setupCollectionView() {
        
        // Setup Cells
        collectionView.registerNib(FrequentContactCell.self)
        collectionView.registerNib(ContactCell.self)

        // Setup Headers
        collectionView.register(HeaderView.nib, forSupplementaryViewOfKind: HeaderView.name, withReuseIdentifier: HeaderView.name)

        // Setup Layout
        collectionView.collectionViewLayout = createLayout()
    }
    
    func frequentContactsSection(contentInset: NSDirectionalEdgeInsets,
                                             headerId: String) -> NSCollectionLayoutSection? {
		//TODO: - Centralize dimensions
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(70 * 2), heightDimension: .absolute(107 * 2)))
        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = contentInset
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [ self.headerSupplementaryView ]

        return section
    }
    
    func otherContactsSection(contentInset: NSDirectionalEdgeInsets,
                                          headerId: String) -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)))
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionContentInsets
        section.boundarySupplementaryItems = [self.headerSupplementaryView]
        return section
    }
    
    var headerSupplementaryView: NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HeaderView.name, alignment: .topLeading)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (section, env) -> NSCollectionLayoutSection? in
            
            guard let self = self else { return nil }
            
            let contactSection = self.sections[section]
            
            switch contactSection {
            case .frequentContacts:
                return self.frequentContactsSection(contentInset: self.sectionContentInsets, headerId: HeaderView.name)
                
            case .mamoContacts, .phoneContacts:
                return self.otherContactsSection(contentInset: self.sectionContentInsets, headerId: HeaderView.name)
            }
        }
    }
}
