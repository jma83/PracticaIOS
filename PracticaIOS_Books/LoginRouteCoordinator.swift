//
//  LoginRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class LoginRouteCoordinator: LoginViewModelRoutingDelegate {
    func userWantsToLogin(_: LoginViewModel) {
        
    }
    
    private let navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init() {
        let userManager = UserManager()
        let loginViewModel = LoginViewModel(userManager: userManager)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        navigationController = UINavigationController(rootViewController: loginViewController)
    }
}
