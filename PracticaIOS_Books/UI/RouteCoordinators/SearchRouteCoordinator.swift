//
//  SearchRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit

class SearchRouteCoordinator: SearchViewModelRoutingDelegate, DetailViewModelRoutingDelegate, CommentsRouteCoordinatorDelegate,  AddToListRouteCoordinatorDelegate {

    private var navigationController: UINavigationController
    private var addToListRouteCoordinator: AddToListRouteCoordinator!
    private var commentsRouteCoordinator: CommentsRouteCoordinator!

    let bookManager: BookManager
    let userManager: UserManager
    var rootViewController: UIViewController {
        return navigationController
    }

    init(bookManager:BookManager, userManager: UserManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        let searchViewModel = SearchViewModel(bookManager: bookManager)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        
        navigationController = UINavigationController(rootViewController: searchViewController)
        searchViewModel.routingDelegate = self
    }
    
    // DetailViewModelRoutingDelegate: From Detail to Comments
    //Redirect to New RouteCoordinator! -> Comments  (Modal)
    func showCommentsView(book: BookResult) {
        commentsRouteCoordinator = CommentsRouteCoordinator(bookManager: bookManager, userManager: userManager)
        rootViewController.present(commentsRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    // DetailViewModelRoutingDelegate: From Detail to Lists
    //Redirect to New RouteCoordinator! -> AddToExistingList (Modal)
    func showAddList(book: BookResult) {
        addToListRouteCoordinator = AddToListRouteCoordinator(bookManager: bookManager, userManager: userManager)
        addToListRouteCoordinator.delegate = self
        rootViewController.present(addToListRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    // AddToListRouteCoordinatorDelegate
    func closeAddToList() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    // CommentsRouteCoordinatorDelegate
    func closeComments() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    // SearchViewModelRoutingDelegate: From Search to Detail
    func watchDetail(book: BookResult) {
        let vm = DetailViewModel(bookManager: bookManager, bookResult: book)
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

}
