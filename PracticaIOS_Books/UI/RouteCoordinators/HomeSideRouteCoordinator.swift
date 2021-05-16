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
    
    weak var delegate: HomeSideRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return leftMenuNavigationController
    }

    init(userManager: UserManager, navController: UINavigationController) {
        // Define the menus
        let homeSideViewModel = HomeSideViewModel(userManager: userManager)
        let homeSideViewController = HomeSideViewController(viewModel: homeSideViewModel)
        self.leftMenuNavigationController = SideMenuNavigationController(rootViewController: homeSideViewController)
        
        initSideMenuConfig(navController: navController)
        homeSideViewModel.routingDelegate = self
    }
    
    func initSideMenuConfig(navController: UINavigationController) {
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navController.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navController.view)
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
