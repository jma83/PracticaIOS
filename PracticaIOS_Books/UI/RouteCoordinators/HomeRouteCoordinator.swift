//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class HomeRouteCoordinator: HomeViewModelRoutingDelegate {
    func watchDetail(_: HomeViewModel, book: BookResult) {
        let vm = DetailViewModel(bookManager: bookManager, isbn: book.primary_isbn10!)
        let vc = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private let navigationController: UINavigationController
    let bookManager: BookManager
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init() {
        bookManager = BookManager()
        let homeViewModel = HomeViewModel(bookManager: bookManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController = UINavigationController(rootViewController: homeViewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        homeViewModel.routingDelegate = self
    }
}
