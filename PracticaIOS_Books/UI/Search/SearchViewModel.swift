//
//  SearchViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 17/04/2021.
//

import Foundation

class SearchViewModel: BookManagerSearchDelegate {
    func searchBookResult(_: BookManager, bookResult: [BookResult]) {
        var count3 = 1;
        var count = 0
        bookViewModels = [ [], [], [], [] ]
        for item in bookResult {
            bookViewModels[count].append(BookViewModel(book: item))
            if count3 == 3 {
                count3 = 1
                count+=1
            }else{
                count3+=1
            }
        }
        
        self.delegate?.searchResult(self)
    }
    
    func bookDetail(_: BookManager, bookResult: BookResult) {
        delegate?.bookChanged(self)
    }
    
    
    
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [ [], [], [], [] ]
    weak var delegate: SearchViewModelDelegate?
    weak var routingDelegate: SearchViewModelRoutingDelegate?
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        self.bookManager.searchDelegate = self
        
    }
    
    func searchBook(text: String){
        bookManager.searchBook(text: text)
    }
     
    func bookDetail(bookResult: BookResult) {
        if let routingDelegate = routingDelegate {
            print(routingDelegate)
            routingDelegate.watchDetail(book: bookResult)
        }
    }
    
}

protocol SearchViewModelDelegate: class {
    func bookChanged(_: SearchViewModel)
    func searchResult(_: SearchViewModel)
}


protocol SearchViewModelRoutingDelegate: class {
    func watchDetail(book: BookResult)
    func showCommentsView(book: BookResult)
}