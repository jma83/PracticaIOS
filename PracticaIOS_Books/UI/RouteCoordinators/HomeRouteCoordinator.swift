//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class HomeRouteCoordinator: HomeViewModelRoutingDelegate, DetailViewModelRoutingDelegate, CommentsRouteCoordinatorDelegate, AddToListRouteCoordinatorDelegate {
    
    private let navigationController: UINavigationController
    private var addToListRouteCoordinator: AddToListRouteCoordinator!
    private var commentsRouteCoordinator: CommentsRouteCoordinator!
    
    let bookManager: BookManager
    let userManager: UserManager
    let listManager: ListManager
    let likeManager: LikeManager
    let commentManager: CommentManager
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(bookManager: BookManager, userManager: UserManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        
        let homeViewModel = HomeViewModel(bookManager: bookManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController = UINavigationController(rootViewController: homeViewController)
        homeViewModel.routingDelegate = self
    }    
    
    // MARK: DetailViewModelRoutingDelegate: From Detail to Comments
    //Redirect to New RouteCoordinator! -> Comments  (Modal)
    func showCommentsView(book: BookResult) {
        commentsRouteCoordinator = CommentsRouteCoordinator(bookManager: bookManager, userManager: userManager, commentManager: commentManager)
        commentsRouteCoordinator.delegate = self
        rootViewController.present(commentsRouteCoordinator.rootViewController, animated: true, completion: nil)
        
    }
    // MARK: DetailViewModelRoutingDelegate: From Detail to Lists
    //Redirect to New RouteCoordinator! -> AddToExistingList  (Modal)
    func showAddList(book: BookResult) {
        //TODO
        addToListRouteCoordinator = AddToListRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager)
        addToListRouteCoordinator.delegate = self
        rootViewController.present(addToListRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    // MARK: AddToListRouteCoordinatorDelegate
    func closeAddToList() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: CommentsRouteCoordinatorDelegate
    func closeComments() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: HomeViewModelRoutingDelegate: From Home to Detail
    func watchDetail(book: BookResult) {
        let vm = DetailViewModel(bookManager: bookManager, userManager: userManager, bookResult: book, likeManager: likeManager)
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
 
