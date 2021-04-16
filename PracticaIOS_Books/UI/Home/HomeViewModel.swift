//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel: BookManagerDelegate {
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [ [], [], [] ]
    weak var delegate: HomeViewModelDelegate?
    weak var routingDelegate: HomeViewModelRoutingDelegate?
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        self.bookManager.delegate = self
        self.bookManager.getRelevantBooks(completition2: { result in
            if let result = result {
                var count = 0
                while count <= 2 {
                    for item in result {
                        self.bookViewModels[count].append(BookViewModel(book: item))
                    }
                    count+=1
                }
                
            }
        })
    }
    
    
    func bookChanged(_: BookManager) {
        delegate?.bookChanged(self)
    }
    
    func bookDetail(bookResult: BookResult) {
        routingDelegate?.refresh()
        routingDelegate?.watchDetail(self, book: bookResult)
    }
    
}

protocol HomeViewModelDelegate: class {
    func bookChanged(_: HomeViewModel)
}

protocol HomeViewModelRoutingDelegate: class {
    func watchDetail(_: HomeViewModel, book: BookResult)
    func refresh()
}
