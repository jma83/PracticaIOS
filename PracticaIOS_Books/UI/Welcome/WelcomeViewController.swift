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
    
    private let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @IBAction func clickRegisterButton() {
        viewModel.handleUserRegister()
    }
    @IBAction func clickLoginButton() {
        viewModel.handleUserAccess()
    }
}

