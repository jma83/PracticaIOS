//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit

class HomeRouteCoordinator: HomeViewModelRoutingDelegate, DetailViewModelRoutingDelegate, CommentsRouteCoordinatorDelegate, AddToListRouteCoordinatorDelegate, ProfileRouteCoordinatorDelegate, ModalViewDelegate {
    
    private let navigationController: UINavigationController
    private var addToListRouteCoordinator: AddToListRouteCoordinator!
    private var commentsRouteCoordinator: CommentsRouteCoordinator!
    private var profileRouteCoordinator: ProfileRouteCoordinator!
    weak var delegate: HomeRouteCoordinatorDelegate?
    
    let bookManager: BookManager
    let userManager: UserManager
    let listManager: ListManager
    let likeManager: LikeManager
    let commentManager: CommentManager
    let userSession: User
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(bookManager: BookManager, userManager: UserManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager, userSession: User) {
        self.userSession = userSession
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        
        let homeViewModel = HomeViewModel(userManager: userManager, bookManager: bookManager, userSession: userSession)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController = UINavigationController(rootViewController: homeViewController)
        homeViewModel.routingDelegate = self
    }    
    
    // MARK: DetailViewModelRoutingDelegate: From Detail to Comments
    //Redirect to New RouteCoordinator! -> Comments  (Modal)
    func showCommentsView(book: BookResult) {
        commentsRouteCoordinator = CommentsRouteCoordinator(bookManager: bookManager, commentManager: commentManager, userSession: userSession, book: book)
        commentsRouteCoordinator.delegate = self
        rootViewController.present(commentsRouteCoordinator.rootViewController, animated: true, completion: nil)
        
    }
    // MARK: DetailViewModelRoutingDelegate: From Detail to Lists
    //Redirect to New RouteCoordinator! -> AddToExistingList  (Modal)
    func showAddList(book: BookResult) {
        addToListRouteCoordinator = AddToListRouteCoordinator(bookManager: bookManager, listManager: listManager, userSession: userSession, book: book)
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
    func watchDetail(_: HomeViewModel, book: BookResult, userSession: User) {
        let vm = DetailViewModel(bookManager: bookManager, likeManager: likeManager, bookResult: book, userSession: userSession)
        vm.routingDelegate = self
        let vc: DetailViewController = DetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func redirectToWelcome(_: HomeViewModel) {
        delegate?.redirectToWelcome(self)
    }
    
    func closeProfile() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func showProfile(_: HomeViewModel) {
        profileRouteCoordinator = ProfileRouteCoordinator(userManager: userManager, userSession: userSession)
        profileRouteCoordinator.delegate = self
        rootViewController.present(profileRouteCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    func showInfoModal(title: String, message: String) {
        let modal = ModalView()
        modal.delegate = self
        rootViewController.present(modal.showAlert(title: title, message: message), animated: true)
    }
    
    func dismissModal(_: ModalView) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
 
protocol HomeRouteCoordinatorDelegate: class {
    func redirectToWelcome(_: HomeRouteCoordinator)
}
