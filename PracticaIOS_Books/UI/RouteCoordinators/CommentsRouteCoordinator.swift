//
//  CommentsRouteCoordinator.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit


class CommentsRouteCoordinator: CommentsViewModelRoutingDelegate, AddCommentViewModelRoutingDelegate, ModalViewDelegate, ModalViewConfirmDelegate {
        
    private var navigationController: UINavigationController
    let bookManager: BookManager
    let bookDetail: BookResult
    let userSession: User
    let commentManager: CommentManager
    let commentViewModel: CommentsViewModel
    weak var delegate: CommentsRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController {
        return navigationController
    }
     
    init(bookManager: BookManager,  commentManager: CommentManager, userSession: User, book: BookResult) {
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookDetail = book
        self.commentManager = commentManager
        commentViewModel = CommentsViewModel(bookManager: bookManager, commentManager: commentManager, userSession: userSession, book: book)
        let vc = CommentsViewController(viewModel: commentViewModel)
        
        
        navigationController = UINavigationController(rootViewController: vc)
        commentViewModel.routingDelegate = self
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
    
    func showInfoModal(title: String, message: String) {
        let modal = ModalView()
        modal.delegate = self
        rootViewController.present(modal.showAlert(title: title, message: message), animated: true)
    }
    
    func dismissModal(_: ModalView) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func showConfirmDeleteModal( title: String, message: String) {
        let modal = ModalView()
        modal.confirmDelegate = self
        rootViewController.present(modal.showConfirmDeleteAlert(title: title, message: message ), animated: true)
    }
    
    func dismissConfirmModal(_: ModalView) {
        self.commentViewModel.cancelDeleteEvent()
        //rootViewController.dismiss(animated: true, completion: nil)
    } 
    
    func confirmDelete(_: ModalView) {
        //rootViewController.dismiss(animated: true, completion: nil)
        self.commentViewModel.confirmDeleteEvent()
    }
    
    
    
}

protocol CommentsRouteCoordinatorDelegate: class {
    func closeComments()
}
