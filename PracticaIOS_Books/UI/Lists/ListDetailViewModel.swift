//
//  ListDetailViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 01/05/2021.
//

import Foundation

class ListDetailViewModel {
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: ListDetailViewModelDelegate?
    weak var routingDelegate: ListDetailViewModelRoutingDelegate?
    var userSession: User?
    var listDetail: List
    let colsPerRow: Int = 3
    init(userSession: User, listDetail: ListViewModel) {
        self.userSession = userSession
        self.listDetail = listDetail.list
        self.getBookLists()
    }
    
    func getBookLists(){
        if let user = userSession, user == listDetail.user, let books = listDetail.books, books.count > 0 {
            var colsCount = 0;
            var count = 0
            self.resetResults(size: books.count)
            for item in books {
                let book = item as! Book
                let bookresult = BookResult(id: book.id, title: book.title, author: book.author ?? "N/A", description: book.descrip, book_image: book.image, created_date: book.date, primary_isbn10: book.isbn)
                bookViewModels[count].append(BookViewModel(bookResult: bookresult))
                if colsCount == (self.colsPerRow - 1) {
                    colsCount = 0
                    count+=1
                }else{
                    colsCount+=1
                }
            }
            self.delegate?.bookChanged(self)
        }
    }
    
    func resetResults(size: Int) {
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
