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
    let userManager: UserManager
    let commentManager: CommentManager
    weak var delegate: CommentsRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager, userManager: UserManager, commentManager: CommentManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.commentManager = commentManager
        let vm = CommentsViewModel(commentManager: commentManager, userManager: userManager)
        let vc = CommentsViewController(viewModel: vm)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        vm.routingDelegate = self
    }
    
    func closeComments(_: CommentsViewModel){
        delegate?.closeComments()
    }
    
    func addComment(_: CommentsViewModel) {
        let vm = AddCommentViewModel(commentManager: CommentManager(), userManager: userManager)
        vm.routingDelegate = self
        let vc = AddCommentViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCommentDetail(_: CommentsViewModel) {
        //TODO
    }
    
    func createCommentResult() {
        navigationController.popViewController(animated: true)
    }
    
}

protocol CommentsRouteCoordinatorDelegate: class {
    func closeComments()
}
