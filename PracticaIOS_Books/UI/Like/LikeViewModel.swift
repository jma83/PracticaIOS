//
//  LikeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 29/04/2021.
//

import Foundation

class LikeViewModel: LikeManagerDelegate {
    
    let likeManager: LikeManager
    let bookManager: BookManager
    let userSession: User?
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: LikeViewModelDelegate?
    weak var routingDelegate: LikeViewModelRoutingDelegate?
    let colsPerRow: Int = 3
    init(bookManager: BookManager, likeManager: LikeManager, userSession: User) {
        self.likeManager = likeManager
        self.userSession = userSession
        self.bookManager = bookManager
        self.likeManager.delegate = self
        
         
    }
    
    func getLikedBooks(){
        if let user = self.userSession {
            self.likeManager.findLikedByUser(user: user)
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
    
    func likeError(_: LikeManager, message: String) {
        self.routingDelegate?.showInfoModal(title: "Error", message: message)
    }
    
    func likeFetchResult(_: LikeManager, books: [BookResult]) {
        self.bookViewModels = []
        self.bookManager.formatBookRows(bookResult: books, maxPerRow: self.colsPerRow, completionHandler: { items in
            for rowItems in items {
                self.bookViewModels.append(rowItems.map({
                    BookViewModel(bookResult: $0)
                }))
            }
            
        })
        self.delegate?.bookChanged(self)
    }

}

protocol LikeViewModelDelegate: class {
    func bookChanged(_: LikeViewModel)
}

protocol LikeViewModelRoutingDelegate: class {
    func watchDetail(_: LikeViewModel, book: BookResult, userSession: User)
    func showInfoModal(title: String, message: String)
}
