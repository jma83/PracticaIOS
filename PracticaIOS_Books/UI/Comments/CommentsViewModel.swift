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
    let bookManager: BookManager
    let userSession: User
    let bookResult: BookResult
    weak var delegate: CommentsViewModelDelegate?
    weak var routingDelegate: CommentsViewModelRoutingDelegate?
    
    init(bookManager: BookManager,commentManager: CommentManager, userSession: User, book: BookResult) {
        self.commentManager = commentManager
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookResult = book
        self.commentManager.delegate = self
        
    }
    
    func getBookComments() {
        self.bookManager.getBook(book: bookResult, completionHandler: { book in
            
            if let book = book, let comments = book.comments {
                self.commentViewModels = []
                for item in comments {
                    let comment = item as? Comment
                    if let comment = comment {
                        var ownComment = false
                        if self.userSession == comment.user {
                            ownComment = true
                        }
                        self.commentViewModels.append(CommentViewModel(comment: comment, ownComment: ownComment))
                    }
                }
                self.delegate?.updateList(self)
            }
        })
        
    }
    
    func addCommentRouting(){
        self.routingDelegate?.addComment(self)
    }
    
    func closeListRouting() {
        self.routingDelegate?.closeComments(self)
    }
    
    func commentDelete(commentViewModel: CommentViewModel){
        self.commentManager.deleteComment(comment: commentViewModel.comment)
    }
    
    func commentDeleteResult(_: CommentManager, comment: Comment) {
        self.getBookComments()
    }
    
}

protocol CommentsViewModelDelegate: class {
    func updateList(_: CommentsViewModel)
}

protocol CommentsViewModelRoutingDelegate: class {
    func addComment(_: CommentsViewModel)
    func closeComments(_: CommentsViewModel)
}
