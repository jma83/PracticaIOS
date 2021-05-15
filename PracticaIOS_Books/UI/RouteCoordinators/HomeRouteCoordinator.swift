//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 12/04/2021.
//

import UIKit
import SideMenu

class HomeRouteCoordinator: HomeViewModelRoutingDelegate, DetailViewModelRoutingDelegate, CommentsRouteCoordinatorDelegate, AddToListRouteCoordinatorDelegate, ProfileRouteCoordinatorDelegate, ModalViewDelegate, HomeSideViewModelRouting, AboutRouteCoordinatorDelegate {
    
    private let navigationController: UINavigationController
    private var addToListRouteCoordinator: AddToListRouteCoordinator!
    private var commentsRouteCoordinator: CommentsRouteCoordinator!
    private var profileRouteCoordinator: ProfileRouteCoordinator!
    private var aboutRouteCoordinator: AboutRouteCoordinator!
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
    let leftMenuNavigationController: SideMenuNavigationController
    
    init(bookManager: BookManager, userManager: UserManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager, userSession: User) {
        self.userSession = userSession
        self.bookManager = bookManager
        self.userManager = userManager
        self.listManager = listManager
        self.likeManager = likeManager
        self.commentManager = commentManager
        
        let homeViewModel = HomeViewModel(bookManager: bookManager, userSession: userSession)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        navigationController = UINavigationController(rootViewController: homeViewController)

        // Define the menus
        let homeSideViewModel = HomeSideViewModel(userManager: userManager)
        let homeSideViewController = HomeSideViewController(viewModel: homeSideViewModel)
        self.leftMenuNavigationController = SideMenuNavigationController(rootViewController: homeSideViewController)
        self.initSideMenuConfig()
        
        homeSideViewModel.routingDelegate = self
        homeViewModel.routingDelegate = self
    }
    
    func initSideMenuConfig() {
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController.view)
        leftMenuNavigationController.statusBarEndAlpha = 0
    }
    
    // MARK: DetailViewModelRoutingDelegate: From Detail to Comments
    func showCommentsView(book: BookResult) {
        commentsRouteCoordinator = CommentsRouteCoordinator(bookManager: bookManager, commentManager: commentManager, userSession: userSession, book: book)
        commentsRouteCoordinator.delegate = self
        rootViewController.present(commentsRouteCoordinator.rootViewController, animated: true, completion: nil)
        
    }
    // MARK: DetailViewModelRoutingDelegate: From Detail to Lists
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
    
    func redirectToWelcome(_: HomeSideViewModel) {
        delegate?.redirectToWelcome(self)
    }
    
    func closeProfile() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func showProfile(_: HomeSideViewModel) {
        rootViewController.dismiss(animated: true, completion: {
            self.profileRouteCoordinator = ProfileRouteCoordinator(userManager: self.userManager, userSession: self.userSession)
            self.profileRouteCoordinator.delegate = self
            self.rootViewController.present(self.profileRouteCoordinator.rootViewController, animated: true, completion: nil)
        })
        
    }
    
    func showSideMenu(_: HomeViewModel) {
        rootViewController.present(leftMenuNavigationController, animated: true, completion: nil)
    }
    
    func showInfoModal(title: String, message: String) {
        let modal = ModalView()
        modal.delegate = self
        rootViewController.present(modal.showAlert(title: title, message: message), animated: true)
    }
    
    func dismissModal(_: ModalView) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func showAbout(_: HomeSideViewModel) {
        rootViewController.dismiss(animated: true, completion: {
            self.aboutRouteCoordinator = AboutRouteCoordinator()
            self.aboutRouteCoordinator?.delegate = self
            self.rootViewController.present(self.aboutRouteCoordinator.rootViewController, animated: true, completion: nil)
        })
        
    }
    
    func closeAbout() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
}
 
protocol HomeRouteCoordinatorDelegate: class {
    func redirectToWelcome(_: HomeRouteCoordinator)
}
