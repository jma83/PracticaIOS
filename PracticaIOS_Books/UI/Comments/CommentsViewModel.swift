//
//  CommentsViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 15/04/2021.
//

import Foundation


class CommentsViewModel: BookManagerDelegate {
    func bookChanged(_: BookManager) {
        //Todo
    }
    
    
    let bookManager: BookManager
    var bookViewModel: BookViewModel?
    weak var delegate: CommentsViewModel?
    weak var routingDelegate: CommentsViewModelRoutingDelegate?
    
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        self.bookManager.delegate = self
    }
    
}

protocol CommentsViewModelDelegate: class {
    func bookDetail(_: DetailViewModel, book: BookResult)
}

protocol CommentsViewModelRoutingDelegate: class {
    func addComment(_: CommentsViewModel)
    func showCommentDetail(_: CommentsViewModel)
}
