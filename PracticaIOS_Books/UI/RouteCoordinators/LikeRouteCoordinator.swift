//
//  LikeRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit
//LikeViewModelRoutingDelegate
class LikeRouteCoordinator: LikeViewModelRoutingDelegate, DetailViewModelRoutingDelegate, CommentsRouteCoordinatorDelegate, AddToListRouteCoordinatorDelegate {
    
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let userManager: UserManager
    let listManager: ListManager
    let likeManager: LikeManager
    let commentManager: CommentManager
    let userSession: User
    var rootViewController: UIViewController {
        return navigationController
    }
    private var addToListRouteCoordinator: AddToListRouteCoordinator!
    private var commentsRouteCoordinator: CommentsRouteCoordinator!

    
    init(bookManager:BookManager, userManager: UserManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager, userSession: User) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        self.userSession = userSession
        let likeViewModel = LikeViewModel(bookManager: bookManager, likeManager: likeManager, userSession: userSession)
            let likeViewController = LikeViewController(viewModel: likeViewModel)
            
            navigationController = UINavigationController(rootViewController: likeViewController)
            likeViewModel.routingDelegate = self
        
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
    
    func watchDetail(_: LikeViewModel, book: BookResult, userSession: User) {
        let vm = DetailViewModel(bookManager: bookManager, likeManager: likeManager, bookResult: book, userSession: userSession)
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
