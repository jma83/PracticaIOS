//
//  LikeRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 19/04/2021.
//

import UIKit
//LikeViewModelRoutingDelegate
class LikeRouteCoordinator: LikeViewModelRoutingDelegate {
    
        
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let userManager: UserManager
    var rootViewController: UIViewController {
        return navigationController
    }

    
    init(bookManager:BookManager, userManager: UserManager) {
            self.bookManager = bookManager
            self.userManager = userManager
        let likeViewModel = LikeViewModel(bookManager: bookManager, userManager: userManager)
            let likeViewController = LikeViewController(viewModel: likeViewModel)
            
            navigationController = UINavigationController(rootViewController: likeViewController)
            likeViewModel.routingDelegate = self
        
    }
    
    
    func watchDetail(book: BookResult) {
        let vm = LikeViewModel(bookManager: bookManager, userManager: userManager)
        vm.routingDelegate = self
        let vc: LikeViewController = LikeViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
