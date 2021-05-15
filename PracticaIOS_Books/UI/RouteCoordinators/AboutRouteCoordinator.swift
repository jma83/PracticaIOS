//
//  AboutRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/05/2021.
//

import UIKit

class AboutRouteCoordinator: AboutViewModelRoutingDelegate {
    
    private var navigationController: UINavigationController
    weak var delegate: AboutRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
    init() {
        let vm = AboutViewModel()
        let vc = AboutViewController(viewModel: vm)
    
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeAbout() {
        self.delegate?.closeAbout()
    }
    
}

protocol AboutRouteCoordinatorDelegate: class {
    func closeAbout()
}

