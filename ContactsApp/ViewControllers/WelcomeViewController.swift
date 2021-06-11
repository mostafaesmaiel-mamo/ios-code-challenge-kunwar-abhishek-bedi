//
//  ViewController.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import UIKit
import iOS_Utils
import Contacts

class WelcomeViewController: UIViewController {

    let viewModel = WelcomeViewModel()
    
    
    //:MARK - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //  Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBActions
	fileprivate func showPermissionPrimingAlert(onOkayAction: @escaping () -> ()) {

		let alert = UIAlertController(title: "#Permission Priming Alert", message: "#Hi! We would like you to grant us access to your contacts so that we can give you an amazing payment experience", preferredStyle: .actionSheet, alertActions: [
			.okay({ _ in
				// Okay Pressed
				onOkayAction()
			})
		])
		present(alert, animated: true)
    }
    
    @IBAction func onEnglishButtonPressed(_ sender: Any) {
        
        if viewModel.shouldShowPermissionPrimingAlert {
			showPermissionPrimingAlert {[weak self] in
				// WIP
			}
        }
    }
    
    @IBAction func onArabicButtonPressed(_ sender: Any) {
    
    }
    
}

//MARK: - Contact Access
fileprivate extension WelcomeViewController {
	func requestContactsAccessAgain() {
		CNContactStore().requestAccess(for: .contacts) { (access, error) in
			print("Access: \(access)")
		}
	}
	
	func askUserToGivePermissionAgain() {
		UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
	}
		
    func requestContactsAccess() {
        // WIP
		let status:CNAuthorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
		
		switch status {
			case .denied, .notDetermined: break
			//            askUserToGivePermissionAgain()
			//            requestContactsAccessAgain()
			default:
				break
		}
    }
}
