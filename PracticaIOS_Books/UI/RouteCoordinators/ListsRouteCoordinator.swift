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
    var rootViewController: UIViewController {
        return navigationController
    }

    
    init(bookManager:BookManager, userManager: UserManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        let vm = ListsMainViewModel(listManager: self.listManager, userManager: self.userManager)
        let vc = ListsMainViewController(viewModel: vm)
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func createList() {
        let vm = CreateListViewModel(listManager: listManager, userManager: userManager)
        vm.routingDelegate = self
        let vc = CreateListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createListResult() {
        navigationController.popViewController(animated: true)
    }
    
    func showBooksFromList(listViewModel: ListViewModel) {
        let vm = ListDetailViewModel(bookManager: bookManager, userManager: userManager)
        vm.routingDelegate = self
        let vc = ListDetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func watchDetail(book: BookResult) {
        let vm = DetailViewModel(bookManager: bookManager, userManager: userManager, bookResult: book, likeManager: likeManager)
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCommentsView(book: BookResult) {
        commentsRouteCoordinator = CommentsRouteCoordinator(bookManager: bookManager, userManager: userManager, commentManager: commentManager)
        commentsRouteCoordinator.delegate = self
        rootViewController.present(commentsRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    func showAddList(book: BookResult) {
        addToListRouteCoordinator = AddToListRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager)
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
