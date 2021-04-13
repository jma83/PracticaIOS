//
//  StartRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class StartRouteCoordinator: WelcomeViewModelRoutingDelegate {
    func userWantsToRegister(_: WelcomeViewModel) {
        //segue a register
    }
    
    func userWantsToAccess(_: WelcomeViewModel) {
        //segue a login
    }
    
    private let navigationController: UIViewController
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init() {
        let userManager = UserManager()
        let welcomeViewModel = WelcomeViewModel(userManager: userManager)
        let welcomeViewController = WelcomeViewController(viewModel: welcomeViewModel)
        
        navigationController = UINavigationController(rootViewController: welcomeViewController)
        
        welcomeViewModel.routingDelegate = self
    }
}
