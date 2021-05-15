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
    let rowsSize = 3
    weak var delegate: HomeViewModelDelegate?
    weak var routingDelegate: HomeViewModelRoutingDelegate?
    
    init(bookManager: BookManager, userSession: User) {
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookManager.homeDelegate = self
    }
    
    func getHomeBooks(){
        self.bookViewModels = []
        self.bookManager.getRelevantBooks(rowsSize: rowsSize)
    }
    
    func bookDetailRouting(bookResult: BookResult) {
        if let user = userSession {
            routingDelegate?.watchDetail(self, book: bookResult, userSession: user)
        }
    }
    
    func showSideMenu(){
        self.routingDelegate?.showSideMenu(self)
    }
    
    //MARK: BookManagerHomeDelegate functions
    
    func homeBooksResult(_: BookManager, books: [[BookResult]]?) {
        if let result = books {
            self.bookViewModels = [[BookViewModel]]()
            for rowBooks in result {
                self.bookViewModels.append(rowBooks.map({BookViewModel(bookResult: $0)}))
            }
        }
        delegate?.bookChanged(self)
    }
    
    func booksSectionResult(_: BookManager, sections: [String]?) {
        if let sections = sections {
            self.sections = sections
        }
    }
    
}

protocol HomeViewModelDelegate: class {
    func bookChanged(_: HomeViewModel)
}

protocol HomeViewModelRoutingDelegate: class {
    func watchDetail(_: HomeViewModel, book: BookResult, userSession: User)
    func showSideMenu(_: HomeViewModel)
}
