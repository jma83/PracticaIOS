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
    weak var routingDelegate: HomeViewModelRoutingDelegate?
    
    init(bookManager: BookManager, isbn: String) {
        self.bookManager = bookManager
        self.bookManager.getBookDetail(isbn: isbn)
        self.bookManager.detailDelegate = self
    }
    
    init(bookManager: BookManager, bookResult: BookResult) {
        self.bookManager = bookManager
        self.bookViewModel = BookViewModel(book: bookResult)
        //self.bookDetail(bookManager, bookResult: bookResult)
        self.bookManager.detailDelegate = self
    }
    
    func bookDetail(_: BookManager, bookResult: BookResult) {
        delegate?.bookDetail(self, book: bookResult)
    }
    
    func showComments() {
        if let bookViewModel = bookViewModel {
        routingDelegate?.showCommentsView(book: bookViewModel.book)
        }
    }
    
    func loadBook(){
        if let book = bookViewModel?.book {
            bookDetail(bookManager, bookResult: book)
        }
    }
}

protocol DetailViewModelDelegate: class {
    func bookDetail(_: DetailViewModel, book: BookResult)
}
