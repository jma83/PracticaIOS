//
//  LoginViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 20/03/2021.
//

import UIKit

class LoginViewController: UIViewController, LoginViewModelDelegate {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel: LoginViewModel?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = LoginViewModel(userManager: UserManager())
        super.init(coder: coder)
        self.viewModel?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func userSession(_: LoginViewModel, didUserChange user: User) {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "NavHomeViewController") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeViewController
        homeViewController.modalPresentationStyle = .overCurrentContext
        present(homeViewController, animated: true)
    }
    

    func userLoginError(_: LoginViewModel, error: String) {
        present(ModalViewController().showAlert(title: "Error", message: error), animated: true)

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
