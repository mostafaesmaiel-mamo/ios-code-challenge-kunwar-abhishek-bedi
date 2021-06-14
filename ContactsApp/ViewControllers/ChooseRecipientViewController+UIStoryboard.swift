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
			}
		}
	}
}

