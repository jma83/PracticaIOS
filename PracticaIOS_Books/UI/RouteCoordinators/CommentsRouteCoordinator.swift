//
//  CommentsRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit


class CommentsRouteCoordinator: CommentsViewModelRoutingDelegate, AddCommentViewModelRoutingDelegate {
       
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let bookDetail: BookResult
    let userSession: User
    let commentManager: CommentManager
    weak var delegate: CommentsRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager,  commentManager: CommentManager, userSession: User, book: BookResult) {
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookDetail = book
        self.commentManager = commentManager
        let vm = CommentsViewModel(bookManager: bookManager, commentManager: commentManager, userSession: userSession, book: book)
        let vc = CommentsViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeComments(_: CommentsViewModel){
        delegate?.closeComments()
    }
    
    func addComment(_: CommentsViewModel) {
        let vm = AddCommentViewModel(bookManager: bookManager, commentManager: commentManager, userSession: userSession, bookResult: bookDetail)
        vm.routingDelegate = self
        let vc = AddCommentViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createCommentResult() {
        navigationController.popViewController(animated: true)
    }
    
}

protocol CommentsRouteCoordinatorDelegate: class {
    func closeComments()
}
