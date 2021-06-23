//
//  ChooseRecipientViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit
import Contacts

final class ChooseRecipientViewController: UIViewController {
    
	//MARK: - IBOutlets
	@IBOutlet private weak var containerView: UIView!
	@IBOutlet private weak var footerView: UIView!
	@IBOutlet private weak var nextButton: UIButton!
	
	//MARK: - Dependencies
	private(set) var phoneContactManager: PhoneContactsFetchable!
	private(set) var mamoContactManager: MamoContactsFetchable!
	
	//MARK: - Variables
	var collectionViewController: CollectionViewController!
	var contactDetailsViewController: ContactDetailsViewController!
	private(set) lazy var loader = LoaderView()
	
	
	//MARK: - ViewController Lifecycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Recipient"
		
		guard phoneContactManager != nil else {
			fatalError("Contact Manager Cannot be Nil")
		}
		
		fetchAllContacts()
		updateNextButton()
	}
	
	func updateNextButton() {
		let isAnyContactSelected = collectionViewController.viewModel.isAnyContactSelected
		updateNextButtonState(isSelected: isAnyContactSelected)
	}
	
	//MARK: - Configuration Methods -  Single Entry Point for This VC
	func configure(_ phoneContactManager: PhoneContactsFetchable = ContactsManager(),
				   _ mamoContactManager: MamoContactsFetchable = ContactsManager()
					) {
		self.phoneContactManager = phoneContactManager
		self.mamoContactManager = mamoContactManager
	}
	
	//MARK: - Fetch Contacts -
	private func fetchAllContacts() {
		hideViewsAndShowLoader()
		
		fetchPhoneContacts { [weak self] contacts in
			
			guard !contacts.isEmpty else {
				self?.showViewsAndHideLoader()
				//TODO: - Put an empty screen here
				return
			}
			
			// Matching Mamo Contacts
			let emails:[String] = contacts.allEmails
			let phones:[String] = contacts.allPhoneNumbers
			
			self?.fetchMamoContacts(emails: emails, phones: phones) { mamoContacts in
				
				self?.fetchFrequentContacts { frequentContacts in
					
					self?.showViewsAndHideLoader()
					self?.updateCollectionViewController(withPhoneContacts: contacts, mamoContacts: mamoContacts, frequentContacts: frequentContacts)
					self?.reload()
					
				}
			}
		}
	}
}


//MARK: - Private UI related functions
fileprivate extension ChooseRecipientViewController {
	
	func updateNextButtonState(isSelected: Bool) {
		nextButton.isEnabled = isSelected
		nextButton.titleLabel?.textColor = isSelected ? .white : MamoColor.gray.value
		nextButton.backgroundColor = isSelected ? MamoColor.blue.value : MamoColor.gray.value
	}
	
	func reload() {
		collectionViewController.collectionView.reloadData()
	}
	
	func updateCollectionViewController(withPhoneContacts phoneContacts: [Contact],
										mamoContacts: [MamoAccount],
										frequentContacts: [Frequent]) {
		
		collectionViewController.configure(withPhoneContacts: phoneContacts, mamoContacts: mamoContacts, frequentContacts: frequentContacts)
	}
	
	func showHideViewsWhileLoading(canShow: Bool) {
		if canShow {
			containerView.isHidden = false
			footerView.isHidden = false
		}
		else {
			containerView.isHidden = true
			footerView.isHidden = true
		}
	}
	
	func hideViewsAndShowLoader() {
		// Fetch All Contacts
		showHideViewsWhileLoading(canShow: false)
		loader.showOn(self.view)
	}
	
	func showViewsAndHideLoader() {
		// Fetch All Contacts
		showHideViewsWhileLoading(canShow: true)
		loader.hide()
	}
}

extension Sequence where Self.Element == Contact {
	var allEmails: [String] {
		
		var allEmails:[String] = []
		self.forEach { contact in
			if let emails = contact.emails {
				allEmails.append(contentsOf: emails)
			}
		}
		return allEmails
	}
	
	var allPhoneNumbers: [String] {
		
		var allPhoneNumbers:[String] = []
		self.forEach { contact in
			if let phoneNumbers = contact.phoneNumbers {
				allPhoneNumbers.append(contentsOf: phoneNumbers)
			}
		}
		return allPhoneNumbers
	}
}
