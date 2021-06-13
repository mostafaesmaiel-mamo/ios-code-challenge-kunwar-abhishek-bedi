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
	private var phoneContactManager: PhoneContactsFetchable!
	private var mamoContactManager: MamoContactsFetchable!
	
	//MARK: - Variable
	private var viewModel =  ChooseRecipientViewModel()
	private var collectionViewController: CollectionViewController!
	lazy var loader = LoaderView()
	
	//MARK: - ViewController Lifecycle Methods
	fileprivate func fetchContacts() {
		// Fetch All Contacts
		showHideViewsWhileLoading(canShow: false)
		loader.showOn(self.view)
		
		fetchPhoneContacts { [weak self] contacts in
			
			guard !contacts.isEmpty else {
				self?.loader.hide()
				//TODO: - Put an empty screen here
				return
			}
			
			// Matching Mamo Contacts
			let emails = contacts.compactMap( { $0.email} )
			let phones = contacts.compactMap( { $0.phoneNumber} )
			
			self?.fetchMamoContacts(emails: emails, phones: phones) { mamoContacts in
				
//				mamoContacts.
				
				self?.showHideViewsWhileLoading(canShow: true)
				self?.loader.hide()
				self?.updateCollectionViewController(contacts: contacts)
				self?.reload()

			}
			
			
			
			
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "#Choose Recipient"
		
		guard phoneContactManager != nil else {
			fatalError("Contact Manager Cannot be Nil")
		}
		
		fetchContacts()
	}
	
	//MARK: - Configuration Methods
	func configure(withPhoneContactManager
					phoneContactManager: PhoneContactsFetchable = ContactsManager(),
				   mamoContactManager: MamoContactsFetchable = ContactsManager()
					) {
		self.phoneContactManager = phoneContactManager
		self.mamoContactManager = mamoContactManager
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

//MARK: - Contacts Related Functions
fileprivate extension ChooseRecipientViewController {
	
	func updateCollectionViewController(contacts: [ContactProtocol]) {
		collectionViewController.configure(withContacts: contacts)
	}
	
	func fetchPhoneContacts(onCompletion: @escaping (([ContactProtocol])-> Void)) {
		
		phoneContactManager.fetchPhoneContacts { phoneContacts in
			onCompletion(phoneContacts)
		}
	}
	
	func fetchMamoContacts(emails: [String], phones: [String], onCompletion: @escaping (([ContactProtocol])-> Void)) {
		
		mamoContactManager.fetchSearchMamoContacts(emails: emails, orPhones: phones) { result in
			
			switch result {
				case .success(let accounts):
					print(accounts)
					
					onCompletion(accounts)
				case .failure(let error):
					print(error.error.description)
					onCompletion([])
			}
		}
		
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
}
