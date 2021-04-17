//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class HomeRouteCoordinator: HomeViewModelRoutingDelegate {
    func watchDetail(book: BookResult) {
        let vm = DetailViewModel(bookManager: bookManager, isbn: book.primary_isbn10!)
        vm.routingDelegate = self
        vc = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc!, animated: true)
    }
    
    private let navigationController: UINavigationController
    private let tabBarController: UITabBarController
    let bookManager: BookManager
    
    var rootViewController: UIViewController {
        return navigationController
    }
    var vc:DetailViewController? 
    
    init() {
        bookManager = BookManager()
        let homeViewModel = HomeViewModel(bookManager: bookManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        
        navigationController = UINavigationController(rootViewController: homeViewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        tabBarController = UITabBarController()
        //tabBarController.setViewControllers([navigationController], animated: true)
        homeViewModel.routingDelegate = self
    }
    
    /*init() {
        bookManager = BookManager()
        let homeViewModel = HomeViewModel(bookManager: bookManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        let searchViewModel = SearchViewModel(bookManager: bookManager)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        tabBarController = UITabBarController()
        
        tabBarController.setViewControllers([homeViewController,searchViewController], animated: true)
        
        self.navigationController = UINavigationController(rootViewController: tabBarController)
        
        self.navigationController.modalPresentationStyle = .fullScreen
        
        guard let items = tabBarController.tabBar.items else {
            return
        }
        
        for item in items {
            item.image = UIImage(systemName: "home")
        }
        
        
        
        homeViewModel.routingDelegate = self
        searchViewModel.routingDelegate = self
    }*/
}
