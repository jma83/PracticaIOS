//
//  AddCommentViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//


class AddCommentViewModel {
    weak var delegate: AddCommentViewModelDelegate?
    weak var routingDelegate: AddCommentViewModelRoutingDelegate?
    let commentManager: CommentManager
    let userSession: User

    init(commentManager: CommentManager, userSession: User) {
        self.commentManager = commentManager
        self.userSession = userSession
        
    }
    
    func createComment(summary: String, descrip: String){
        //TODO
        //commentManager.createComment(summary: String, descrip: String)
        commentUpdatedResult(self.commentManager, didListChange: List())
    }
    
    func commentUpdatedResult(_: CommentManager, didListChange list: List) {
        self.routingDelegate?.createCommentResult()
    }
    
    func commentError(_: ListManager, error: String) {
        delegate?.commentError(self, message: error)
    }

}

protocol AddCommentViewModelDelegate: class {
    func commentError(_: AddCommentViewModel, message: String)
}

protocol AddCommentViewModelRoutingDelegate: class {
    func createCommentResult()
}
