//
//  SearchViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 17/04/2021.
//

import Foundation

class SearchViewModel: BookManagerSearchDelegate {
    func searchBook(_: BookManager, bookResult: [BookResult]) {
        var count3 = 1;
        var count = 0
        for item in bookResult {
            if count3 == 3 {
                bookViewModels[count].append(BookViewModel(book: item))
                count3 = 1
                count+=1
            }else{
                count3+=1
            }
        }
    }
    
    func bookDetail(_: BookManager, bookResult: BookResult) {
        delegate?.bookChanged(self)
    }
    
    
    
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [ [] ]
    weak var delegate: SearchViewModelDelegate?
    weak var routingDelegate: HomeViewModelRoutingDelegate?
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
}
