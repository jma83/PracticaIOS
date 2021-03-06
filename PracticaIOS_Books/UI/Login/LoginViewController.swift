//
//  LoginViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 20/03/2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel: LoginViewModel?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardEvent()
        self.usernameText.delegate = self
        self.passwordText.delegate = self

        passwordText.isSecureTextEntry = true
    }
    
    @IBAction func clickLoginButton() {
        guard let username = usernameText.text, username.count > 0 else{
            return
        }
        guard let password = passwordText.text, password.count > 0 else{
            return
        }
                
        viewModel?.validateAndLogin(username: username, password: password)
        
    }

}
