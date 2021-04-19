//
//  ListsRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit
//ListsViewModelRoutingDelegate
class ListsRouteCoordinator {
        
    private var navigationController: UINavigationController?
    let bookManager: BookManager
    var rootViewController: UIViewController? {
        return navigationController
    }

    
    init(bookManager:BookManager) {
        self.bookManager = bookManager
    }
}
