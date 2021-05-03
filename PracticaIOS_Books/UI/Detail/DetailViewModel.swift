//
//  DetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 13/04/2021.
//

import Foundation

class DetailViewModel: BookManagerDetailDelegate, LikeManagerDelegate {
    

    let bookManager: BookManager
    let likeManager: LikeManager
    let userManager: UserManager
    var userSession: User? = nil
    var bookViewModel: BookViewModel?
    weak var delegate: DetailViewModelDelegate?
    weak var routingDelegate: DetailViewModelRoutingDelegate?

    init(bookManager: BookManager,userManager: UserManager, bookResult: BookResult, likeManager: LikeManager) {
        self.likeManager = likeManager
        self.userManager = userManager
        self.bookManager = bookManager
        self.bookViewModel = BookViewModel(book: bookResult)
        self.bookManager.detailDelegate = self
    }
    
    func bookDetail(_: BookManager, bookResult: BookResult?) {
        if let result = bookResult, checkValidResult(property: result.title), self.checkValidResult(property: self.bookViewModel?.book.primary_isbn10) {
            self.bookViewModel = BookViewModel(book: result)
            delegate?.bookDetailResult(self)
            return
        }
        self.loadDefaultBook()
    }
    

    func loadBook(){
        if let isbn = self.bookViewModel?.book.primary_isbn10 {
            self.bookManager.getBookDetail(isbn: isbn)
        }
    }
    
    func loadDefaultBook(){
        if let book = self.bookViewModel?.book {
            self.bookViewModel = BookViewModel(book: book)
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
        if let bookR = self.bookViewModel?.book {
            self.bookManager.createBook(book: bookR)
        }
        
    }
    
    func showComments() {
        if let bookViewModel = bookViewModel {
            routingDelegate?.showCommentsView(book: bookViewModel.book)
        }
    }
    
    func addBookToList() {
        if let bookViewModel = bookViewModel {
            routingDelegate?.showAddList(book: bookViewModel.book)
        }
    }
    
    func userSession(_: UserManager, didUserChange user: User) {
        self.userSession = user
    }
    
    func userCredentialError(_: UserManager, error: String) {
        //show error getting current User
    }
    
    func createBookResult(_: BookManager, book: Book?) {
        if let book = book, let user = userSession {
            likeManager.manageLike(book: book, user: user)
        }
    }
    
    func likeAddResult(_: LikeManager, like: [Like]) {
        //TODO
    }
    
    func likeError(_: LikeManager, message: String) {
        //TODO
    }
    
    func likeFetchResult(_: LikeManager, like: [Like]) {
        //TODO
    }
    
}

protocol DetailViewModelDelegate: class {
    func bookDetailResult(_: DetailViewModel)
}

protocol DetailViewModelRoutingDelegate: class {
    func showCommentsView(book: BookResult)
    func showAddList(book: BookResult)
}
