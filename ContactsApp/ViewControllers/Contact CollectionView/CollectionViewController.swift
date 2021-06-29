//
//  ViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {

	private(set) var viewModel: ContactViewModel = ContactViewModel()
	
    var sections: [Section] = []
	
	var onContactInteraction: (() -> ())?

    //MARK:- View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSections()
        setupCollectionView()
    }
	
	//MARK: - Configuration - Single Entry Point
	func configure(withPhoneContacts phoneContacts: [Contact],
							mamoContacts: [MamoAccount],
							frequentContacts: [Frequent]) {
		viewModel.configure(withPhoneContacts: phoneContacts, mamoContacts: mamoContacts, frequentContacts: frequentContacts)
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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		guard let contact = viewModel.contact(atIndexPath: indexPath) else {
			return UICollectionViewCell()
		}
		
        let section = sections[indexPath.section]

		switch section {
			case .frequentContacts:
				if let cell = frequentContactCell(collectionView, forIndexPath: indexPath) {
					cell.configure(with: contact)
					return cell
				}
				
			case .mamoContacts, .phoneContacts:

				if let cell = otherContactCell(collectionView, forIndexPath: indexPath) {
					cell.configure(with: contact)
					return cell
				}
		}

		return UICollectionViewCell()
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if indexPath.section == Section.frequentContacts.rawValue {
			viewModel.contact(atIndexPath: indexPath)?.toggleSelection()
			reloadCollectionViewSections(collectionView)
			onContactInteraction?()
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.name, for: indexPath) as? HeaderView {
			let title = sections[indexPath.section].headerTitle
			header.configure(with: title)
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
	
	func reloadCollectionViewSections(_ collectionView: UICollectionView) {
		UIView.performWithoutAnimation {
			collectionView.reloadSections([Section.frequentContacts.rawValue,
										   Section.mamoContacts.rawValue])
		}
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
}
