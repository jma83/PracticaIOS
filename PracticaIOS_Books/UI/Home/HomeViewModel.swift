//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel: BookManagerDelegate {
    
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [[]]
    var sections: [String] = []
    weak var delegate: HomeViewModelDelegate?
    weak var routingDelegate: HomeViewModelRoutingDelegate?
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        self.bookManager.delegate = self
    }
    
    func getHomeBooks(){
        self.bookViewModels = []
        self.bookManager.getRelevantBooks()
    }
    
    func booksChanged(_: BookManager, books: [[BookResult]]?) {
        if let result = books {
            var count = 0
            self.bookViewModels = [[BookViewModel]](repeating: [], count: result.count)
            for listCat in result {
                for item in listCat {
                    self.bookViewModels[count].append(BookViewModel(book: item))
                }
                count+=1
            }
        }
        delegate?.bookChanged(self)
    }
    
    func booksSectionChanged(_: BookManager, sections: [String]?) {
        if let sections = sections {
            self.sections = sections
        }
    }
    
    func bookDetailRouting(bookResult: BookResult) {
        if let routingDelegate = routingDelegate {
            print(routingDelegate)
            routingDelegate.watchDetail(book: bookResult)
        }
    }
    
}

protocol HomeViewModelDelegate: class {
    func bookChanged(_: HomeViewModel)
}

protocol HomeViewModelRoutingDelegate: class {
    func watchDetail(book: BookResult)
}
