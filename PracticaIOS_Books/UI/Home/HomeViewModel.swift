//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel: BookManagerHomeDelegate, UserHomeManagerDelegate {

    
    let userManager: UserManager
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [[]]
    var sections: [String] = []
    let userSession: User?
    let rowsSize = 3
    weak var delegate: HomeViewModelDelegate?
    weak var routingDelegate: HomeViewModelRoutingDelegate?
    
    init(userManager: UserManager, bookManager: BookManager, userSession: User) {
        self.userManager = userManager
        self.bookManager = bookManager
        self.userSession = userSession
        self.bookManager.homeDelegate = self
        self.userManager.homeDelegate = self
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
    
    func logoutUser(){
        self.userManager.removeUserSession()
    }
    
    func showProfileRouting() {
        self.routingDelegate?.showProfile(self)
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
    
    //MARK: UserHomeManagerDelegate functions
    
    func userLogoutResult(_: UserManager) {
        self.routingDelegate?.redirectToWelcome(self)
    }
    
}

protocol HomeViewModelDelegate: class {
    func bookChanged(_: HomeViewModel)
}

protocol HomeViewModelRoutingDelegate: class {
    func watchDetail(_: HomeViewModel, book: BookResult, userSession: User)
    func redirectToWelcome(_: HomeViewModel)
    func showProfile(_: HomeViewModel)
}
