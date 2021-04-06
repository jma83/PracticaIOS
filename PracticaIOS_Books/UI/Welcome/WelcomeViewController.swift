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
        performSegue(withIdentifier: "welcomeToRegister", sender: self)
        
    }
    @IBAction func clickLoginButton() {
        performSegue(withIdentifier: "welcomeToLogin", sender: self)
        
    }
    
    func presentViewController(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

