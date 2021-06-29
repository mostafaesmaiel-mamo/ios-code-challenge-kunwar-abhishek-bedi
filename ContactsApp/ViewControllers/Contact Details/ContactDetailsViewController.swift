//
//  ContactDetailsViewController.swift
//  ContactsApp
//
//  Created by kbedi on 15/06/2021.
//

import UIKit

class ContactDetailsViewController: UIViewController {

	//MARK: - IBOutlets
	@IBOutlet private weak var imageView: RoundedImageView!
	@IBOutlet private weak var logoView: UIView!
	@IBOutlet private weak var firstNameLabel: UILabel!
	@IBOutlet private weak var lastNameLabel: UILabel!
	@IBOutlet private weak var textView: UITextView!
	
	private var contact: ContactProtocol!
	
	func configure(with contact: ContactProtocol) {
		self.contact = contact
	}
	
	private func description(for contact: ContactProtocol) -> String {
		
        var strings: [String] = []
		strings.append("Contact: \(contact.publicName)")
		strings.append("Id: \(contact.id)")
		strings.append("Phone Number/Email: \(contact.phoneNumbers?.first ?? contact.emails?.first ?? "")")
		strings.append("Mamo: \(contact.isMamoContact)")
		strings.append("Frequent: \(contact.isFrequentContact)")
		
		return strings.joined(separator: "\n")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        navigationItem.title = "Selected Contact Info"
		guard contact != nil else {
			fatalError("Conact should be initialized. Use configure func")
		}
		
        // Do any additional setup after loading the view.
		setupUI()
    }
    
	func setupUI() {
		firstNameLabel.text = contact.firstName
		lastNameLabel.text = contact.lastName
		logoView.isHidden = !contact.isMamoContact
		textView.text = description(for: contact)
		imageView.setup(withContact: contact)
	}
}
