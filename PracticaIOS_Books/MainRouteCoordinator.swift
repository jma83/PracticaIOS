//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class HomeRouteCoordinator {
    private let navigationController: UIViewController
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init() {
        let bookManager = BookManager()
        let homeViewModel = HomeViewModel(bookManager: bookManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController = UINavigationController(rootViewController: homeViewController)
    }
}
