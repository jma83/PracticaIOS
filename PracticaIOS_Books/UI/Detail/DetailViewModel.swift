//
//  DetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 13/04/2021.
//

import Foundation

class DetailViewModel: BookManagerDetailDelegate {
    func bookDetail(_: BookManager, bookResult: BookResult) {
        delegate?.bookDetail(self, book: bookResult)
    }
    


    let bookManager: BookManager
    var bookViewModel: BookViewModel?
    weak var delegate: DetailViewModelDelegate?
    
    init(bookManager: BookManager, isbn: String) {
        self.bookManager = bookManager
        self.bookManager.getBookDetail(isbn: isbn)
        self.bookManager.detailDelegate = self
    }
    
    
}

protocol DetailViewModelDelegate: class {
    func bookDetail(_: DetailViewModel, book: BookResult)
}
