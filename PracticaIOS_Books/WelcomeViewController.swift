//
//  WelcomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 18/03/2021.
//

import UIKit

class WelcomeViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickRegisterButton() {
        let vm = RegisterViewModel(userManager: UserManager())
        let vc = RegisterViewController(viewModel: vm)
        presentViewController(viewController: vc);
        
    }
    @IBAction func clickLoginButton() {
        let vm = LoginViewModel(userManager: UserManager())
        let vc = LoginViewController(viewModel: vm)
        presentViewController(viewController: vc)
        
    }
    
    func presentViewController(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

