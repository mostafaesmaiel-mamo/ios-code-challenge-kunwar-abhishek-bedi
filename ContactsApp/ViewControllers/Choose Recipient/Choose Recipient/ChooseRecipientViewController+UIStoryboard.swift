//
//  ChooseRecipientViewController+UIStoryboard.swift
//  ContactsApp
//
//  Created by kbedi on 14/06/2021.
//
import UIKit
extension ChooseRecipientViewController {
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segue_embed" {
			if let vc = segue.destination as? CollectionViewController {
				collectionViewController = vc
				collectionViewController.onContactInteraction = updateNextButton
			}
		}
		else if segue.identifier == "segue_push_contact_details" {
			if let vc = segue.destination as? ContactDetailsViewController {
				contactDetailsViewController = vc
				guard let contact = collectionViewController.viewModel.contacts.first(where: {$0.isSelected}) else {
					return
				}
				contactDetailsViewController.configure(with: contact)
			}
		}
	}
}

