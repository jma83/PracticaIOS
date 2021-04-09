//
//  WelcomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 18/03/2021.
//

import UIKit

class WelcomeViewController: UIViewController, UINavigationControllerDelegate, WelcomeViewModelDelegate {
    
    let name = UIApplication.protectedDataDidBecomeAvailableNotification

    func userFound(_: UserManager, user: User) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc =  HomeViewController(viewModel: HomeViewModel(bookManager: BookManager()))
        navigationController?.setViewControllers([vc], animated: true)
        appDelegate.window?.rootViewController = navigationController
    }
    

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        let selector = #selector(Self.protectedDataAvailableNotification(_:))
                switch UIApplication.shared.isProtectedDataAvailable {
                case true  : self.dataDidBecomeAvailable()
                case false: NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
                }
        self.viewModel.delegate = self
    }
    
    @objc func protectedDataAvailableNotification(_ notification: Notification) {
            NotificationCenter.default.removeObserver(self, name: name, object: nil)
            dataDidBecomeAvailable()
        }
    
    required init?(coder: NSCoder) {
        self.viewModel = WelcomeViewModel(userManager: UserManager())
        super.init(coder: coder)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func dataDidBecomeAvailable() {
        viewModel.checkUser();
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

