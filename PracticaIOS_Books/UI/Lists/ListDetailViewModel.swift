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
    init(bookManager: BookManager, userManager: UserManager) {
        self.bookManager = bookManager
        self.bookManager.listDelegate = self
        self.getListDetailBooks()
        
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
            routingDelegate.watchDetail(book: bookResult)
        }
    }
}

protocol ListDetailViewModelDelegate: class {
    func bookChanged(_: LikeViewModel)
}

protocol ListDetailViewModelRoutingDelegate: class {
    func watchDetail(book: BookResult)
}
