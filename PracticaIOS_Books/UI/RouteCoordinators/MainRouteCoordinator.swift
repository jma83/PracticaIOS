//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//


import UIKit

class MainRouteCoordinator: HomeRouteCoordinatorDelegate{
    
    private let tabBarController: UITabBarController
    weak var delegate: MainRouteCoordinatorDelegate?
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    let homeRouteCoordinator: HomeRouteCoordinator
    let searchRouteCoordinator: SearchRouteCoordinator
    let listsRouteCoordinator: ListsRouteCoordinator
    let likeRouteCoordinator: LikeRouteCoordinator
    
    
    init(userManager: UserManager, bookManager: BookManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager, userSession: User) {
        
        homeRouteCoordinator = HomeRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager, userSession: userSession)
        searchRouteCoordinator = SearchRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager, userSession: userSession)
        listsRouteCoordinator = ListsRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager, userSession: userSession)
        likeRouteCoordinator = LikeRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager, userSession: userSession)
    
        
        tabBarController = UITabBarController()
        
        homeRouteCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house"))
        searchRouteCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "plus.magnifyingglass"))
        likeRouteCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Like", image: UIImage(systemName: "hand.thumbsup.fill"), selectedImage: UIImage(systemName: "hand.thumbsup"))
        listsRouteCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(systemName: "books.vertical.fill"), selectedImage: UIImage(systemName: "books.vertical"))
        tabBarController.setViewControllers([homeRouteCoordinator.rootViewController, searchRouteCoordinator.rootViewController,likeRouteCoordinator.rootViewController,listsRouteCoordinator.rootViewController], animated: true)
        
        homeRouteCoordinator.delegate = self

        
               
    }
    
    func redirectToWelcome(_: HomeRouteCoordinator) {
        delegate?.redirectToWelcome(self)
    }
}

protocol MainRouteCoordinatorDelegate: class {
    func redirectToWelcome(_: MainRouteCoordinator)
}
