//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class HomeRouteCoordinator: HomeViewModelRoutingDelegate {
    
    private let navigationController: UINavigationController
    let bookManager: BookManager
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func showCommentsView(book: BookResult) {
        let vm = CommentsViewModel(bookManager: bookManager)
        vm.routingDelegate = self
        let vc2: CommentsViewController = CommentsViewController(viewModel: vm)
        navigationController.pushViewController(vc2, animated: true)
    }
    func watchDetail(book: BookResult) {
        var vm: DetailViewModel;
        if let isbn = book.primary_isbn10, isbn != "None", isbn != "" {
            vm = DetailViewModel(bookManager: bookManager, isbn: book.primary_isbn10!)
        }else{
            vm = DetailViewModel(bookManager: bookManager, bookResult: book)
        }
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        let homeViewModel = HomeViewModel(bookManager: bookManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController = UINavigationController(rootViewController: homeViewController)
        homeViewModel.routingDelegate = self
    }
}
