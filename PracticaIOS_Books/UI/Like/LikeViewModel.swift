//
//  LikeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 29/04/2021.
//

import Foundation

class LikeViewModel: BookManagerLikeDelegate {
    
    let likeManager: LikeManager
    let userManager: UserManager
    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: LikeViewModelDelegate?
    weak var routingDelegate: LikeViewModelRoutingDelegate?
    init(bookManager: BookManager, userManager: UserManager, likeManager: LikeManager) {
        self.bookManager = bookManager
        self.userManager = userManager
        self.likeManager = likeManager
        self.bookManager.likeDelegate = self
        self.getLikedBooks()
        
    }
    
    func getLikedBooks(){
        //TODO
        //call bookManager and Usermanager to get the books with likes for this user
       // self.likeManager.findLikedByUser(user: )
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

protocol LikeViewModelDelegate: class {
    func bookChanged(_: LikeViewModel)
}

protocol LikeViewModelRoutingDelegate: class {
    func watchDetail(book: BookResult)
}
