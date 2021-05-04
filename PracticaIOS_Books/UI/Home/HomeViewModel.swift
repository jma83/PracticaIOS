//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel: BookManagerHomeDelegate {
    
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [[]]
    var sections: [String] = []
    let userSession: User?
    weak var delegate: HomeViewModelDelegate?
    weak var routingDelegate: HomeViewModelRoutingDelegate?
    
    init(bookManager: BookManager, userSession: User) {
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookManager.delegate = self

    }
    
    func getHomeBooks(){
        self.bookViewModels = []
        self.bookManager.getRelevantBooks()
    }
    
    func homeBooksResult(_: BookManager, books: [[BookResult]]?) {
        if let result = books {
            var count = 0
            self.bookViewModels = [[BookViewModel]](repeating: [], count: result.count)
            for listCat in result {
                for item in listCat {
                    self.bookViewModels[count].append(BookViewModel(bookResult: item))
                }
                count+=1
            }
        }
        delegate?.bookChanged(self)
    }
    
    func booksSectionResult(_: BookManager, sections: [String]?) {
        if let sections = sections {
            self.sections = sections
        }
    }
    
    func bookDetailRouting(bookResult: BookResult) {
        if let routingDelegate = routingDelegate, let user = userSession {
            print(routingDelegate)
            routingDelegate.watchDetail(self, book: bookResult, userSession: user)
        }
    }
    
}

protocol HomeViewModelDelegate: class {
    func bookChanged(_: HomeViewModel)
}

protocol HomeViewModelRoutingDelegate: class {
    func watchDetail(_: HomeViewModel, book: BookResult, userSession: User)
    func redirectToWelcome(_: HomeViewModel)
}
