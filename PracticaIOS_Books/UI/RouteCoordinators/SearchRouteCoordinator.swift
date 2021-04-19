//
//  SearchRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit

class SearchRouteCoordinator: SearchViewModelRoutingDelegate {
    func watchDetail(book: BookResult) {
        //TODO
    }
    
    func showCommentsView(book: BookResult) {
        //TODO
    }
    
        
    private var navigationController: UINavigationController
    let bookManager: BookManager
    var rootViewController: UIViewController {
        return navigationController
    }

    
    init(bookManager:BookManager) {
        self.bookManager = bookManager
        let searchViewModel = SearchViewModel(bookManager: bookManager)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        navigationController = UINavigationController(rootViewController: searchViewController)
        searchViewModel.routingDelegate = self
    }
}
