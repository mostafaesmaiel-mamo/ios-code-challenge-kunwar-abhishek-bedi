//
//  ChooseRecipientViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit
import Contacts

class ChooseRecipientViewController: UIViewController {
    
	//MARK: - IBOutlets
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var footerView: UIView!

	
	//MARK: - Dependencies
	private(set) var phoneContactManager: PhoneContactsFetchable!
	private(set) var mamoContactManager: MamoContactsFetchable!
	
	
	//MARK: - Variables
	private(set) var collectionViewController: CollectionViewController!
	private(set) lazy var loader = LoaderView()
	
	
	//MARK: - ViewController Lifecycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "#Choose Recipient"
		
		guard phoneContactManager != nil else {
			fatalError("Contact Manager Cannot be Nil")
		}
		
		fetchAllContacts()
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
			let emails = contacts.filteredEmails
			let phones = contacts.compactMap({ $0.phoneNumber })
			
			self?.fetchMamoContacts(emails: emails, phones: phones) { mamoContacts in
				
				self?.fetchFrequentContacts { frequentContacts in
					
					let allContacts = contacts + mamoContacts + frequentContacts
					self?.showViewsAndHideLoader()
					self?.updateCollectionViewController(contacts: allContacts)
					self?.reload()
					
				}
			}
		}
	}
}

extension ChooseRecipientViewController {
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segue_embed" {
			if let vc = segue.destination as? CollectionViewController {
				collectionViewController = vc
			}
		}
	}
	
	func reload() {
		collectionViewController.collectionView.reloadData()
	}
}

//MARK: - Private UI related functions
fileprivate extension ChooseRecipientViewController {
	
	func updateCollectionViewController(contacts: [ContactProtocol]) {
		collectionViewController.configure(withContacts: contacts)
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
