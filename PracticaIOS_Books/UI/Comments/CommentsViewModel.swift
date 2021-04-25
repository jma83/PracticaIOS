//
//  CommentsViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/04/2021.
//

import Foundation


class CommentsViewModel: CommentManagerDelegate {
        
    var commentViewModels: [CommentViewModel] = []
    let commentManager: CommentManager
    let userManager: UserManager
    weak var delegate: CommentsViewModelDelegate?
    weak var routingDelegate: CommentsViewModelRoutingDelegate?
    
    init(commentManager: CommentManager, userManager: UserManager) {
        self.commentManager = commentManager
        self.userManager = userManager
        self.retrieveComments()
        
    }
    
    func retrieveComments() {
        //TODO
        // call commentManagerMethod to retrieve Comments for this book
        
    }
    
    func commentsResult(_: CommentManager, didCommentChange comment: Comment) {
        //update viewModel
    }
    
    func addCommentRouting(){
        self.routingDelegate?.addComment(self)
    }
    
    func closeListRouting() {
        self.routingDelegate?.closeComments(self)
    }
    
    
}

protocol CommentsViewModelDelegate: class {
    func updateList(_: CommentsViewModel)
}

protocol CommentsViewModelRoutingDelegate: class {
    func addComment(_: CommentsViewModel)
    func closeComments(_: CommentsViewModel)
    func showCommentDetail(_: CommentsViewModel)
}
