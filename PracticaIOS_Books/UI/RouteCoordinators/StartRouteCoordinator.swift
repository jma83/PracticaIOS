//
//  StartRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class StartRouteCoordinator: WelcomeViewModelRoutingDelegate {
    func userWantsToRegister(_: WelcomeViewModel) {
        let vm = RegisterViewModel(userManager: userManager)
        vm.routingDelegate = self
        let vc = RegisterViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func userWantsToAccess(_: WelcomeViewModel) {
        let vm = LoginViewModel(userManager: userManager)
        vm.routingDelegate = self
        let vc = LoginViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func userAccessAllowed() {
        self.mainRouteCoordinator = MainRouteCoordinator(userManager: userManager, bookManager: bookManager)
        if let mainRouteCoordinator = mainRouteCoordinator {
            rootViewController.present(mainRouteCoordinator.rootViewController, animated: true, completion: nil)
        }
    }
    
    private let navigationController: UINavigationController
    private var mainRouteCoordinator: MainRouteCoordinator?
    
    private let userManager: UserManager
    private let bookManager: BookManager

    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(userManager: UserManager, bookManager: BookManager) {
        self.userManager = userManager
        self.bookManager = bookManager
        let welcomeViewModel = WelcomeViewModel(userManager: userManager)
        let welcomeViewController = WelcomeViewController(viewModel: welcomeViewModel)
        navigationController = UINavigationController(rootViewController: welcomeViewController)
        
        welcomeViewModel.routingDelegate = self
    }
}
