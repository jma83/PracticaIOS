//
//  SearchViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 17/04/2021.
//

import Foundation

class SearchViewModel: BookManagerSearchDelegate {
    
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = []
    weak var delegate: SearchViewModelDelegate?
    weak var routingDelegate: SearchViewModelRoutingDelegate?
    let colsPerRow: Int = 3
    let userSession: User?
    
    init(bookManager: BookManager, userSession: User) {
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookManager.searchDelegate = self
    }
    
    func searchBook(text: String){
        bookManager.searchBook(text: text, maxResults: 30)
    }
    
    func bookDetailRouting(bookResult: BookResult) {
        if let routingDelegate = routingDelegate {
            if let user = userSession {
                routingDelegate.watchDetail(self, book: bookResult, userSession: user)
            }
        }
    }
    
    func resetAndShow() {
        self.bookViewModels = []
        self.delegate?.searchResult(self)
    }
    
    // MARK: BookManagerSearchDelegate functions
    
    func searchBookResult(_: BookManager, bookResult: [BookResult]) {
        self.bookViewModels = []
        self.bookManager.formatBookRows(bookResult: bookResult, maxPerRow: self.colsPerRow, completionHandler: { items in
            for rowItems in items {
                self.bookViewModels.append(rowItems.map({
                    BookViewModel(bookResult: $0)
                }))
            }
            
        })
        
        self.delegate?.searchResult(self)
    }

}

protocol SearchViewModelDelegate: class {
    func bookChanged(_: SearchViewModel)
    func searchResult(_: SearchViewModel)
}


protocol SearchViewModelRoutingDelegate: class {
    func watchDetail(_: SearchViewModel, book: BookResult, userSession: User)
}
