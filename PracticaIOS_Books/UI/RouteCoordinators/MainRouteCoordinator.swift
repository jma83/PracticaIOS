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
    var listsRouteCoordinator: ListsRouteCoordinator?
    var likeRouteCoordinator: LikeRouteCoordinator?
    
    
    init() {
        let bookManager = BookManager()
        
        homeRouteCoordinator = HomeRouteCoordinator(bookManager: bookManager)
        searchRouteCoordinator = SearchRouteCoordinator(bookManager: bookManager)
        //listsRouteCoordinator = ListsRouteCoordinator(bookManager: bookManager)
        //likeRouteCoordinator = LikeRouteCoordinator(bookManager: bookManager)
    
        
        tabBarController = UITabBarController()
        tabBarController.setViewControllers([homeRouteCoordinator.rootViewController, searchRouteCoordinator.rootViewController], animated: true)
        
        tabBarController.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "magnifyingglass")
        
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        /*
         ,listsRouteCoordinator.rootViewController!, likeRouteCoordinator.rootViewController!
         */
        
               
    }
}