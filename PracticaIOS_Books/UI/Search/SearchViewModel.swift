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
        self.resetResults()
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
    
    func bookDetailRouting(bookResult: BookResult) {
        if let routingDelegate = routingDelegate {
            print(routingDelegate)
            routingDelegate.watchDetail(book: bookResult)
        }
    }
    
    func resetResults(){
        bookViewModels = [ [], [], [], [] ]
    }
    
    func resetAndShow() {
        self.resetResults()
        self.delegate?.searchResult(self)
    }
    
}

protocol SearchViewModelDelegate: class {
    func bookChanged(_: SearchViewModel)
    func searchResult(_: SearchViewModel)
}


protocol SearchViewModelRoutingDelegate: class {
    func watchDetail(book: BookResult)
}
