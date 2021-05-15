//
//  HomeSideRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/05/2021.
//

import UIKit
import SideMenu


class HomeSideRouteCoordinator: HomeSideViewModelRouting {
    
    let leftMenuNavigationController: SideMenuNavigationController
    
    private var navigationController: UINavigationController
    weak var delegate: HomeSideRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }

    init(userManager: UserManager, viewController: UIViewController) {
        // Define the menus
        let homeSideViewModel = HomeSideViewModel(userManager: userManager)
        let homeSideViewController = HomeSideViewController(viewModel: homeSideViewModel)
        self.leftMenuNavigationController = SideMenuNavigationController(rootViewController: homeSideViewController)
        
        navigationController = UINavigationController(rootViewController: viewController)
        
        homeSideViewModel.routingDelegate = self
    }
    
    func initSideMenuConfig() {
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController.view)
        leftMenuNavigationController.statusBarEndAlpha = 0
    }
    
    func showProfile(_: HomeSideViewModel) {
        delegate?.showProfile()
    }
    
    func showAbout(_: HomeSideViewModel) {
        delegate?.showAbout()
    }
    
    func redirectToWelcome(_: HomeSideViewModel) {
        delegate?.redirectToWelcome()
    }
}

protocol HomeSideRouteCoordinatorDelegate: class {
    func showProfile()
    func showAbout()
    func redirectToWelcome()
}
