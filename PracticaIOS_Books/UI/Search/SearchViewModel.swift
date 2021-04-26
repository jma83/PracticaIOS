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
    
    func resetResults(size: Int){
        bookViewModels = []
        var cont = 0
        if colsPerRow > 0 {
            let sizeForCols = size/colsPerRow
            while sizeForCols > cont {
                bookViewModels.append([])
                cont+=1
            }
        }
    }
    
    func resetAndShow() {
        self.resetResults(size: 0)
        self.delegate?.searchResult(self)
    }
    
    func searchBookResult(_: BookManager, bookResult: [BookResult]) {
        var colsCount = 0;
        var count = 0
        self.resetResults(size: bookResult.count)
        for item in bookResult {
            bookViewModels[count].append(BookViewModel(book: item))
            if colsCount == (self.colsPerRow - 1) {
                colsCount = 0
                count+=1
            }else{
                colsCount+=1
            }
        }
        
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
