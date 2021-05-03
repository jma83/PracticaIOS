//
//  MainRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//


import UIKit

class MainRouteCoordinator {
    private let tabBarController: UITabBarController
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    let homeRouteCoordinator: HomeRouteCoordinator
    let searchRouteCoordinator: SearchRouteCoordinator
    let listsRouteCoordinator: ListsRouteCoordinator
    let likeRouteCoordinator: LikeRouteCoordinator
    
    
    init(userManager: UserManager, bookManager: BookManager, listManager: ListManager, likeManager: LikeManager, commentManager: CommentManager) {
        
        homeRouteCoordinator = HomeRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager)
        searchRouteCoordinator = SearchRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager)
        listsRouteCoordinator = ListsRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager)
        likeRouteCoordinator = LikeRouteCoordinator(bookManager: bookManager, userManager: userManager, listManager: listManager, likeManager: likeManager, commentManager: commentManager)
    
        
        tabBarController = UITabBarController()
        tabBarController.setViewControllers([homeRouteCoordinator.rootViewController, searchRouteCoordinator.rootViewController,likeRouteCoordinator.rootViewController,listsRouteCoordinator.rootViewController], animated: true)
        
        tabBarController.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "magnifyingglass")
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "hand.thumbsup.fill")
        tabBarController.tabBar.items?[3].image = UIImage(systemName: "books.vertical.fill")
        
        
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        
               
    }
}
