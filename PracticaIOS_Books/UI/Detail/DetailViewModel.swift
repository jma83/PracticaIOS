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
    
    func loadBook(){
        if let book = bookViewModel?.book {
            self.checkLiked(book: book)
            return
        }
        if let isbn = self.bookViewModel?.bookResult.primary_isbn10, let id = self.bookViewModel?.bookResult.id {
                self.bookManager.getBookDetail(isbn: isbn, id: id)
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
            self.bookManager.createBook(book: bookR, completionHandler: { book in
                if let user = self.userSession {
                    self.likeManager.manageLike(book: book, user: user)
                }
            })
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
    
    //MARK: BookManagerDetailDelegate functions
    
    func bookResultDetail(_: BookManager, bookResult: BookResult?){
        if let result = bookResult, checkValidResult(property: result.title), self.checkValidResult(property: self.bookViewModel?.bookResult.primary_isbn10) {
            self.bookViewModel = BookViewModel(bookResult: result)
            delegate?.bookDetailResult(self)
            return
        }
        self.loadDefaultBook()
    }
    
    func bookDetail(_: BookManager, book: Book?){
        if let book = book {
            self.bookViewModel?.book = book
            self.checkLiked(book: book)
        }
        
    }
    
    func checkLiked(book: Book){
        if let user = userSession {
            likeManager.checkLikedByBookAndUser(user: user, book: book)
        }
    }
    
    //MARK: LikeManagerDetailDelegate functions
    
    func likeAddResult(_: LikeManager, checkLike: Bool) {
        self.delegate?.likeAddResult(self, checkLike: checkLike)
    }
    
    func likeError(_: LikeManager, message: String) {
        self.routingDelegate?.showInfoModal(title: "Error", message: message)
    }
    
    func likeCheckBook(_: LikeManager, checkLike: Bool) {
        self.delegate?.likeCheckBook(self, checkLike: checkLike)

    }
    
}

protocol DetailViewModelDelegate: class {
    func bookDetailResult(_: DetailViewModel)
    func likeAddResult(_: DetailViewModel, checkLike: Bool)
    func likeCheckBook(_: DetailViewModel, checkLike: Bool)
}

protocol DetailViewModelRoutingDelegate: class {
    func showCommentsView(book: BookResult)
    func showAddList(book: BookResult)
    func showInfoModal(title: String, message: String)
}
