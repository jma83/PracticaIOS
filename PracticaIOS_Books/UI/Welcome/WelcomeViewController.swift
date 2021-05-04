//
//  WelcomeViewController.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 18/03/2021.
//

import UIKit

class WelcomeViewController: UIViewController, UINavigationControllerDelegate,WelcomeViewModelDelegate {

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
    
    func userSessionError(_: WelcomeViewModel, message: String) {
        present(ModalView().showAlert(title: "Error", message: message), animated: true)
    }
}

