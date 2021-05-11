//
//  ProfileRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 11/05/2021.
//

import UIKit

class ProfileRouteCoordinator: ProfileViewModelRoutingDelegate {
    
    private var navigationController: UINavigationController
    private let userManager: UserManager
    private let userSession: User
    weak var delegate: ProfileRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(userManager: UserManager, userSession: User) {
        self.userManager = userManager
        self.userSession = userSession
        let vm = ProfileViewModel(userManager: userManager, userSession: userSession)
        let vc = ProfileViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func showModalInfo(title: String, message: String) {
        rootViewController.present(ModalView().showAlert(title: title, message: message), animated: true)
    }
    
    func changePassword(_: ProfileViewModel) {
        let vm = ProfileChangePassViewModel(userManager: userManager, userSession: userSession)
        vm.routingDelegate = self
        let vc = ProfileChangePassViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func closeProfile(_: ProfileViewModel) {
        self.delegate?.closeProfile()
    }
    
}

protocol ProfileRouteCoordinatorDelegate: class {
    func closeProfile()
}
