//
//  StartRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class StartRouteCoordinator: WelcomeViewModelRoutingDelegate, MainRouteCoordinatorDelegate, ModalViewDelegate {
   
    private let navigationController: UINavigationController
    private var mainRouteCoordinator: MainRouteCoordinator?
    
    private let userManager: UserManager
    private let bookManager: BookManager
    private let listManager: ListManager
    private let likeManager: LikeManager
    private let commentManager: CommentManager
    private var welcomePresenter: Bool


    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(userManager: UserManager, bookManager: BookManager,  listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager) {
        self.userManager = userManager
        self.bookManager = bookManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        self.welcomePresenter = true
        
        let welcomeViewModel = WelcomeViewModel(userManager: userManager)
        let welcomeViewController = WelcomeViewController(viewModel: welcomeViewModel)
        navigationController = UINavigationController(rootViewController: welcomeViewController)
        
        welcomeViewModel.routingDelegate = self
    }
    
    func userWantsToRegister(_: WelcomeViewModel) {
        let vm = RegisterViewModel(userManager: userManager)
        vm.routingDelegate = self
        self.welcomePresenter = false

        let vc = RegisterViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func userWantsToAccess(_: WelcomeViewModel) {
        let vm = LoginViewModel(userManager: userManager)
        vm.routingDelegate = self
        self.welcomePresenter = false

        let vc = LoginViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func userAccessAllowed(userSession: User) {
        self.mainRouteCoordinator = MainRouteCoordinator(userManager: userManager, bookManager: bookManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager, userSession: userSession)
        
        if let mainRouteCoordinator = mainRouteCoordinator {
            mainRouteCoordinator.delegate = self
            rootViewController.present(mainRouteCoordinator.rootViewController, animated: true, completion: nil)
        }
    }
    
    func redirectToWelcome(_: MainRouteCoordinator) {
        rootViewController.dismiss(animated: true, completion: nil)
        if self.welcomePresenter == false {
            navigationController.popViewController(animated: true)
        }
        
    }
    
    func showInfoModal(title: String, message: String){
        rootViewController.present(ModalView().showAlert(title: title, message: message), animated: true)
    }
    
    func dismissModal() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
