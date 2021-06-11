//
//  WelcomeViewController+ContactAccess.swift
//  ContactsApp
//
//  Created by kbedi on 11/06/2021.
//

import Contacts
import iOS_Utils

//MARK: - Contact Access
extension WelcomeViewController {
	
	func showPermissionPrimingAlert(message: String, onOkayAction: (() -> ())? = nil ) {
		
		let alert = UIAlertController(title: "#Permission Priming Alert", message: message, preferredStyle: .actionSheet, alertActions: [
			.okay({ _ in
				// Okay Pressed
				onOkayAction?()
			})
		])
		present(alert, animated: true)
	}
	
	func requestPermissionViaSettings() {
		UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
	}
	
	func requestContactsAccess(onCompletion: @escaping (Bool)->()) {
		CNContactStore().requestAccess(for: .contacts) { (access, error) in
			onCompletion(access)
		}
	}
}
