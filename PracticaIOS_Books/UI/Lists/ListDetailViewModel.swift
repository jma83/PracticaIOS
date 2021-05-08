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
    init(listManager: ListManager,userSession: User, listDetail: ListViewModel) {
        self.listManager = listManager
        self.userSession = userSession
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
        var colsCount = 0;
        var count = 0
        self.resetResults(size: books.count)
        for book in books {
            bookViewModels[count].append(BookViewModel(bookResult: book))
            if colsCount == (self.colsPerRow - 1) {
                colsCount = 0
                count+=1
            }else{
                colsCount+=1
            }
        }
    }
    
    func resetResults(size: Int) {
        bookViewModels = []
        var cont = 0
        if colsPerRow > 0 {
            let sizeForCols = size/colsPerRow
            while sizeForCols >= cont {
                bookViewModels.append([])
                cont+=1
            }
        }
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
