//
//  DetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 13/04/2021.
//

import Foundation

class DetailViewModel: BookManagerDetailDelegate, LikeManagerDetailDelegate {
    
    let bookManager: BookManager
    let likeManager: LikeManager
    var userSession: User? = nil
    var bookViewModel: BookViewModel?
    weak var delegate: DetailViewModelDelegate?
    weak var routingDelegate: DetailViewModelRoutingDelegate?

    init(bookManager: BookManager, likeManager: LikeManager, bookResult: BookResult, userSession: User) {
        self.likeManager = likeManager
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookViewModel = BookViewModel(bookResult: bookResult)
        self.bookManager.detailDelegate = self
        self.likeManager.detailDelegate = self
    }
    func bookResultDetail(_: BookManager, bookResult: BookResult?){
        if let result = bookResult, checkValidResult(property: result.title), self.checkValidResult(property: self.bookViewModel?.bookResult.primary_isbn10) {
            self.bookViewModel = BookViewModel(bookResult: result)
            delegate?.bookDetailResult(self)
            return
        }
        self.loadDefaultBook()
    }
    func bookDetail(_: BookManager, book: Book?){
        if let book = book, let user = userSession {
            bookViewModel?.book = book
            likeManager.checkLikedByBookAndUser(user: user, book: book)
        }
        
    }
    

    func loadBook(){
        if let isbn = self.bookViewModel?.bookResult.primary_isbn10 {
            self.bookManager.getBookDetail(isbn: isbn)
        }
    }
    
    func loadDefaultBook(){
        if let book = self.bookViewModel?.bookResult {
            self.bookViewModel = BookViewModel(bookResult: book)
            delegate?.bookDetailResult(self)
        }
    }
    
    func checkValidResult(property: String?) -> Bool {
        if property != nil && property != "None" && property != "" {
            return true
        }
        
        return false
    }
    
    func likeBook() {
        if let bookR = self.bookViewModel?.bookResult {
            self.bookManager.createBook(book: bookR)
        }
    }
    
    func showCommentsRouting() {
        if let bookViewModel = bookViewModel {
            routingDelegate?.showCommentsView(book: bookViewModel.bookResult)
        }
    }
    
    func addBookToListRouting() {
        if let bookViewModel = bookViewModel {
            routingDelegate?.showAddList(book: bookViewModel.bookResult)
        }
    }

    func createBookResult(_: BookManager, book: Book?) {
        if let book = book, let user = userSession {
            likeManager.manageLike(book: book, user: user)
        }
    }
    
    func likeAddResult(_: LikeManager, checkLike: Bool) {
        self.delegate?.likeAddResult(self, checkLike: checkLike)
    }
    
    func likeError(_: LikeManager, message: String) {
        self.delegate?.likeError(self, message: message)
    }
    
    func likeCheckBook(_: LikeManager, checkLike: Bool) {
        if checkLike == true {
            self.delegate?.likeCheckBook(self)
        }
    }
    
}

protocol DetailViewModelDelegate: class {
    func bookDetailResult(_: DetailViewModel)
    func likeAddResult(_: DetailViewModel, checkLike: Bool)
    func likeError(_: DetailViewModel, message: String)
    func likeCheckBook(_: DetailViewModel)
}

protocol DetailViewModelRoutingDelegate: class {
    func showCommentsView(book: BookResult)
    func showAddList(book: BookResult)
}
