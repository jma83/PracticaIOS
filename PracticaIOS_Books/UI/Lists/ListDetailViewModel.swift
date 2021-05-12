//
//  ListDetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import Foundation

class ListDetailViewModel: ListDetailManagerDelegate {
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: ListDetailViewModelDelegate?
    weak var routingDelegate: ListDetailViewModelRoutingDelegate?
    var userSession: User?
    var listDetail: List
    let colsPerRow: Int = 3
    let listManager: ListManager
    let bookManager: BookManager
    init(bookManager: BookManager, listManager: ListManager,userSession: User, listDetail: ListViewModel) {
        self.listManager = listManager
        self.userSession = userSession
        self.bookManager = bookManager
        self.listDetail = listDetail.list
        self.listManager.listDetailDelegate = self
        self.getBookLists()
    }
    
    func getBookLists(){
        if let user = userSession, user == listDetail.user, let books = listDetail.books, books.count > 0 {
            self.listManager.getBooksResultFromList(list: listDetail)
            
            self.delegate?.bookChanged(self)
        }
    }
    
    func booksListResult(_: ListManager, books: [BookResult]) {
        self.bookViewModels = []
        self.bookManager.formatBookRows(bookResult: books, maxPerRow: self.colsPerRow, completionHandler: { items in
            for rowItems in items {
                self.bookViewModels.append(rowItems.map({
                    BookViewModel(bookResult: $0)
                }))
            }
            
        })
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
    func bookChanged(_: ListDetailViewModel)
}

protocol ListDetailViewModelRoutingDelegate: class {
    func watchDetail(_: ListDetailViewModel, book: BookResult, userSession: User)
}
