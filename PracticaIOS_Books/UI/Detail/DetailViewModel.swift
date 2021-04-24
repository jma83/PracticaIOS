//
//  DetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 13/04/2021.
//

import Foundation

class DetailViewModel: BookManagerDetailDelegate {

    

    let bookManager: BookManager
    var bookViewModel: BookViewModel?
    weak var delegate: DetailViewModelDelegate?
    weak var routingDelegate: DetailViewModelRoutingDelegate?

    init(bookManager: BookManager, bookResult: BookResult) {
        self.bookManager = bookManager
        self.bookViewModel = BookViewModel(book: bookResult)
        self.bookManager.detailDelegate = self
    }
    
    func bookDetail(_: BookManager, bookResult: BookResult?) {
        if let result = bookResult, checkValidResult(property: result.title) {
            self.bookViewModel = BookViewModel(book: result)
            delegate?.bookDetailResult(self)
            return
        }
        self.loadDefaultBook()
    }
    
    func showComments() {
        if let bookViewModel = bookViewModel {
            routingDelegate?.showCommentsView(book: bookViewModel.book)
        }
    }
    
    func loadBook(){
        if let isbn = self.bookViewModel?.book.primary_isbn10, self.checkValidResult(property: isbn) {
            self.bookManager.getBookDetail(isbn: isbn)
        }else{
            self.loadDefaultBook()
        }
    }
    
    func loadDefaultBook(){
        if let book = self.bookViewModel?.book {
            self.bookDetail(bookManager, bookResult: book)
        }
    }
    
    func checkValidResult(property: String?) -> Bool {
        if property != nil && property != "None" && property != "" {
            return true
        }
        
        return false
    }
}

protocol DetailViewModelDelegate: class {
    func bookDetailResult(_: DetailViewModel)
}

protocol DetailViewModelRoutingDelegate: class {
    func showCommentsView(book: BookResult)
}
