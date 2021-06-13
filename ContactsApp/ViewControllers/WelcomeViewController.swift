//
//  ViewController.swift
//  ContactsApp
//
//  Created by kbedi on 10/06/2021.
//

import UIKit
import Contacts

class WelcomeViewController: UIViewController {

    private let viewModel = WelcomeViewModel()
    
	private let contactAccessMessage = "#Hi! We would like you to grant us access to your contacts so that we can give you an amazing payment experience"
	private let contactAccessDeniedMessage = "#Hi! It seems that you have not given us access to your contacts. Please provide access via Settings apps. We dont store any personal information."
	private let contactAccessRestrictedMessage = "#Hi! It seems that you have active restrictions such as parental controls, etc in place."

    
    //:MARK - View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //  Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBActions
    @IBAction func onEnglishButtonPressed(_ sender: Any) {
		
		switch viewModel.contactPermissionStatus {
			
			case .notDetermined:
				showPermissionPrimingAlert(message: contactAccessMessage) {
					self.requestContactsAccess {[weak self] access in
						print("Access: \(access)")
						if access {
							self?.showContactViewController()
						}
						else {
							print("User Denied Access")
						}
					}
				}
			
			case .restricted:
				showPermissionPrimingAlert(message: contactAccessRestrictedMessage)

			case .denied:
				showPermissionPrimingAlert(message: contactAccessDeniedMessage, onOkayAction: requestPermissionViaSettings)
							
			case .authorized:
				showContactViewController()

			@unknown default:
				fatalError()
		}
    }
    
    @IBAction func onArabicButtonPressed(_ sender: Any) {
		// WIP
    }
    
}

//MARK: - Other Private Functions
fileprivate extension WelcomeViewController {
	func showContactViewController() {
		
		DispatchQueue.main.async {
			guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: ChooseRecipientViewController.name) as? ChooseRecipientViewController else {
				return
			}
			vc.configure()
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}
