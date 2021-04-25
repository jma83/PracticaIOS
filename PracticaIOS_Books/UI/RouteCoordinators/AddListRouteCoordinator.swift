//
//  AddListRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit

class AddToListRouteCoordinator {
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let userManager: UserManager
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(bookManager: BookManager, userManager: UserManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        
        self.bookManager = bookManager
        let searchViewModel = SearchViewModel(bookManager: bookManager)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        navigationController = UINavigationController(rootViewController: searchViewController)
        searchViewModel.routingDelegate = self
        //Invoke VM and VC
    }
}
