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
	
	lazy var loader = LoaderView()
	
	func configure(withContactManager manager: PhoneContactsFetchable = ContactsManager()) {
		contactManager = manager
	}
	
	//MARK: - ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "#Choose Recipient"
		
		guard contactManager != nil else {
			fatalError("Contact Manager Cannot be Nil")
		}
		
		fetchPhoneContacts()
    }
}

fileprivate extension ChooseRecipientViewController {
	
	func fetchPhoneContacts() {
		showHideViewsWhileLoading(canShow: false)
		loader.showOn(self.view)
		
//		contactManager.fetchContacts(fromStore: <#T##CNContactStore#>, withKeys: <#T##[String]#>, onCompletion: <#T##(Bool) -> ()#>)
		
		contactManager.fetchContacts() { [weak self] isSuccess in
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
