//
//  ListsRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit
class ListsRouteCoordinator:  CreateListViewModelRoutingDelegate, ListsMainViewModelRoutingDelegate, ListDetailViewModelRoutingDelegate, DetailViewModelRoutingDelegate, AddToListRouteCoordinatorDelegate, CommentsRouteCoordinatorDelegate {
        
    private var navigationController: UINavigationController
    private var addToListRouteCoordinator: AddToListRouteCoordinator!
    private var commentsRouteCoordinator: CommentsRouteCoordinator!
    let bookManager: BookManager
    let userManager: UserManager
    let listManager: ListManager
    let likeManager: LikeManager
    let commentManager: CommentManager
    let userSession: User
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(bookManager:BookManager, userManager: UserManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager, userSession: User) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        self.userSession = userSession
        let vm = ListsMainViewModel(listManager: listManager, userSession: userSession)
        let vc = ListsMainViewController(viewModel: vm)
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func createList(_:ListsMainViewModel, userSession: User) {
        let vm =  CreateListViewModel(listManager: listManager, userSession: userSession)
        vm.routingDelegate = self
        let vc = CreateListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createListResult() {
        navigationController.popViewController(animated: true)
    }
    
    func showBooksFromList(_: ListsMainViewModel, listViewModel: ListViewModel, userSession: User) {
        let vm = ListDetailViewModel(listManager: listManager, userSession: userSession, listDetail: listViewModel)
        vm.routingDelegate = self
        let vc = ListDetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func watchDetail(_: ListDetailViewModel, book: BookResult, userSession: User) {
        let vm = DetailViewModel(bookManager: bookManager, likeManager: likeManager, bookResult: book, userSession: userSession)
        vm.routingDelegate = self
        let vc = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCommentsView(book: BookResult) {
        commentsRouteCoordinator = CommentsRouteCoordinator(bookManager: bookManager, commentManager: commentManager, userSession: userSession, book: book)
        commentsRouteCoordinator.delegate = self
        rootViewController.present(commentsRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    func showAddList(book: BookResult) {
        addToListRouteCoordinator = AddToListRouteCoordinator(bookManager: bookManager, listManager: listManager, userSession: userSession, book: book)
        addToListRouteCoordinator.delegate = self
        rootViewController.present(addToListRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    func closeAddToList() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func closeComments() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
}

