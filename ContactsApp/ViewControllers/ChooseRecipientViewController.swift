//
//  ChooseRecipientViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class ChooseRecipientViewController: UIViewController {
    
	//MARK: - IBOutlets
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var footerView: UIView!

	//MARK: - Variables
	private var contactManager: PhoneContactsFetchable!
	private var viewModel: ChooseRecipientViewModel =  ChooseRecipientViewModel()
	private var collectionViewController: ChooseContactCollectionViewController!
	lazy var loader = LoaderView()
	
	//MARK: - ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "#Choose Recipient"
		
		guard contactManager != nil else {
			fatalError("Contact Manager Cannot be Nil")
		}
		
		fetchPhoneContacts()
	}
	
	//MARK: - Configuration Methods
	func configure(withContactManager manager: PhoneContactsFetchable = ContactsManager()) {
		contactManager = manager
	}
}

extension ChooseRecipientViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segue_embed" {
			if let vc = segue.destination as? ChooseContactCollectionViewController {
				collectionViewController = vc
			}
		}
	}
}

//MARK: - Contacts Related Functions
fileprivate extension ChooseRecipientViewController {
	
	func fetchPhoneContacts() {
		showHideViewsWhileLoading(canShow: false)
		loader.showOn(self.view)
		
		contactManager.fetchContacts { [weak self] phoneContacts in
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Deliberately put to show the spinner
				self?.showHideViewsWhileLoading(canShow: true)
				self?.loader.hide()
				
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
