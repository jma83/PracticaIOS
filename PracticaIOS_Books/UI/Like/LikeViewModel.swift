//
//  LikeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 29/04/2021.
//

import Foundation

class LikeViewModel: BookManagerDelegate {
    
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: LikeViewModelDelegate?
    weak var routingDelegate: LikeViewModelRoutingDelegate?
    init(bookManager: BookManager, userManager: UserManager) {
        self.bookManager = bookManager
        self.bookManager.delegate = self
        self.getLikedBooks()
        
    }
    
    func getLikedBooks(){
        //TODO
        //call bookManager and Usermanager to get the books with likes for this user
    }
    
    func booksChanged(_: BookManager, books: [[BookResult]]?) {
        
    }
    
    func booksSectionChanged(_: BookManager, sections: [String]?) {
        //NO_RULES?
    }
    
    func bookDetailRouting(bookResult: BookResult) {
        if let routingDelegate = routingDelegate {
            print(routingDelegate)
            routingDelegate.watchDetail(book: bookResult)
        }
    }
}

protocol LikeViewModelDelegate: class {
    func bookChanged(_: LikeViewModel)
}

protocol LikeViewModelRoutingDelegate: class {
    func watchDetail(book: BookResult)
}
