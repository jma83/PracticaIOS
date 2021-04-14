//
//  WelcomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 18/03/2021.
//

import UIKit

class WelcomeViewController: UIViewController, UINavigationControllerDelegate, WelcomeViewModelDelegate {
    
    func userFound(_: UserManager, user: User) {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "NavHomeViewController") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = homeViewController
        homeViewController.modalPresentationStyle = .overCurrentContext
        present(homeViewController, animated: true)
    }
    

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func clickRegisterButton() {
        viewModel.handleUserRegister()
    }
    @IBAction func clickLoginButton() {
        viewModel.handleUserAccess()
    }
    
    func presentViewController(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? RegisterViewController {
            dvc.viewModel = RegisterViewModel(userManager: UserManager())
        }else if let dvc = segue.destination as? LoginViewController {
            dvc.viewModel = LoginViewModel(userManager: UserManager())
        }
        
    } */
    
}

