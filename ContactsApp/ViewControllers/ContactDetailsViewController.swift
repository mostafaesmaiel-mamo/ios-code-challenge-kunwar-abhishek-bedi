//
//  ContactDetailsViewController.swift
//  ContactsApp
//
//  Created by kbedi on 15/06/2021.
//

import UIKit

class ContactDetailsViewController: UIViewController {

	//MARK: - IBOutlets
	@IBOutlet weak var imageView: RoundedImageView!
	@IBOutlet weak var logoView: UIView!
	@IBOutlet weak var firstNameLabel: UILabel!
	@IBOutlet weak var lastNameLabel: UILabel!
	@IBOutlet weak var textView: UITextView!
	
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
