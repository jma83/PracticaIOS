//
//  CommentsRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit


class CommentsRouteCoordinator: CommentsViewModelRoutingDelegate {
       
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let userManager: UserManager
    //let listManager: ListManager
    // REEPLACE LISTMANAGER FOR COMMENTSMANAGER
    weak var delegate: CommentsRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager, userManager: UserManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        //self.listManager = ListManager()
        let vm = CommentsViewModel(bookManager: bookManager)
        let vc = CommentsViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeComments(){
        delegate?.closeComments()
    }
    
    func addComment(_: CommentsViewModel) {
        //TODO
    }
    
    func showCommentDetail(_: CommentsViewModel) {
        //TODO
    }
}

protocol CommentsRouteCoordinatorDelegate: class {
    func closeComments()
}
