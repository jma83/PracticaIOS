//
//  AddCommentViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//


class AddCommentViewModel: AddCommentManagerDelegate {
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
        let commentVM = CommentViewModel(summary: summary, descrip: descrip)
        if !commentVM.validate() {
            self.commentError(self.commentManager, error: commentVM.getError())
            return
        }
        self.bookManager.createBook(book: bookDetail, completionHandler: { book in
            self.commentManager.createComment(commentResult: commentVM.commentResult!, user: self.userSession, book: book)
        })
    }
    
    func commentUpdatedResult(_: CommentManager, didListChange comment: Comment) {
        self.routingDelegate?.createCommentResult()
    }
    
    func commentError(_: CommentManager, error: String) {
        self.routingDelegate?.showInfoModal(title: "Error", message: error)
    }

}

protocol AddCommentViewModelRoutingDelegate: class {
    func createCommentResult()
    func showInfoModal(title: String, message: String)
}
