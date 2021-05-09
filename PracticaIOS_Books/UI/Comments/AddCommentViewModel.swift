//
//  AddCommentViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//


class AddCommentViewModel: AddCommentManagerDelegate {
    weak var delegate: AddCommentViewModelDelegate?
    weak var routingDelegate: AddCommentViewModelRoutingDelegate?
    let commentManager: CommentManager
    let bookManager: BookManager
    let bookDetail: BookResult
    let userSession: User

    init(bookManager: BookManager,commentManager: CommentManager, userSession: User, bookResult: BookResult) {
        self.commentManager = commentManager
        self.bookManager = bookManager
        self.bookDetail = bookResult
        self.userSession = userSession
        self.commentManager.delegateAdd = self
        
    }
    
    func createComment(summary: String, descrip: String){
        self.bookManager.createBook(book: bookDetail, completionHandler: { book in
            self.commentManager.createComment(name: summary, descrip: descrip, user: self.userSession, book: book)
        })
        
    }
    
    func commentUpdatedResult(_: CommentManager, didListChange comment: Comment) {
        self.routingDelegate?.createCommentResult()
    }
    
    func commentError(_: CommentManager, error: String) {
        delegate?.commentError(self, message: error)
    }

}

protocol AddCommentViewModelDelegate: class {
    func commentError(_: AddCommentViewModel, message: String)
}

protocol AddCommentViewModelRoutingDelegate: class {
    func createCommentResult()
}
