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
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = LoginViewModel(userManager: UserManager())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickLoginButton() {
        guard let username = usernameText.text, username.count > 0 else{
            return
        }
        guard let password = passwordText.text, password.count > 0 else{
            return
        }
                
        let res = viewModel.validateAndLogin(username: username, password: password)
        
        if let res = res {
            present(ModalViewController().showAlert(title: "Error", message: res), animated: true)
        }
    }
    
    func userSession(_: LoginViewModel, didUserChange user: User) {
        performSegue(withIdentifier: "loginToHome", sender: self)
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
