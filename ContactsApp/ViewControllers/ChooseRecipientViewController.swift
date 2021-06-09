//
//  ChooseRecipientViewController.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

import UIKit

class ChooseRecipientViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Recipient"
        // Do any additional setup after loading the view.
//        addChild(chooseContactVC)
    }
//    private func add(asChildViewController viewController: UIViewController) {
//        // Add Child View Controller
//        addChild(viewController)
//
//        // Add Child View as Subview
//        view.addSubview(viewController.view)
//
//        // Configure Child View
//        viewController.view.frame = view.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        // Notify Child View Controller
//        viewController.didMove(toParent: self)
//    }
//
//    private lazy var chooseContactVC: ChooseContactViewController = {
//        // Load Storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//        // Instantiate View Controller
//        var viewController = storyboard.instantiateViewController(withIdentifier: ChooseContactViewController.name) as! ChooseContactViewController
//
//        // Add View Controller as Child View Controller
//        self.add(asChildViewController: viewController)
//
//        return viewController
//    }()


}
