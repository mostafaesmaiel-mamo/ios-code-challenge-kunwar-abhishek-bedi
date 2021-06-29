//
//  CollectionViewController+Layout.swift
//  ContactsApp
//
//  Created by kbedi on 16/06/2021.
//
import UIKit

fileprivate let sectionContentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

extension CollectionViewController {

	func frequentContactsSection(headerId: String) -> NSCollectionLayoutSection? {
		//TODO: - Centralize dimensions
		let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(70 * 2), heightDimension: .absolute(107 * 2)))
		item.contentInsets.trailing = 16
		item.contentInsets.bottom = 16
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = sectionContentInsets
		
		section.orthogonalScrollingBehavior = .continuous
		
		section.boundarySupplementaryItems = [ self.headerSupplementaryView ]
		
		return section
	}

	func otherContactsSection(headerId: String) -> NSCollectionLayoutSection? {
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
					return self.frequentContactsSection(headerId: HeaderView.name)
					
				case .mamoContacts, .phoneContacts:
					return self.otherContactsSection(headerId: HeaderView.name)
			}
		}
	}
}

