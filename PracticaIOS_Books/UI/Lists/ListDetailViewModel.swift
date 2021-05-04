//
//  ListDetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import Foundation

class ListDetailViewModel: BookManagerListDelegate {
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: ListDetailViewModelDelegate?
    weak var routingDelegate: ListDetailViewModelRoutingDelegate?
    var userSession: User?
    init(bookManager: BookManager, userSession: User) {
        self.bookManager = bookManager
        self.bookManager.listDelegate = self
        self.getListDetailBooks()
        self.userSession = userSession
        
        
    }
    
    func getListDetailBooks(){
        //TODO
        //call bookManager and Usermanager to get the books with likes for this user
    }
    
    func booksChanged(_: BookManager, books: [[BookResult]]?) {
        
    }
    
    func bookDetailRouting(bookResult: BookResult) {
        if let routingDelegate = routingDelegate {
            print(routingDelegate)
            if let user = userSession {
            routingDelegate.watchDetail(self, book: bookResult, userSession: user)
            }
        }
    }
}

protocol ListDetailViewModelDelegate: class {
    func bookChanged(_: LikeViewModel)
}

protocol ListDetailViewModelRoutingDelegate: class {
    func watchDetail(_: ListDetailViewModel, book: BookResult, userSession: User)
}
