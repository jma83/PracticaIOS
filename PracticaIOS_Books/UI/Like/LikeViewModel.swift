//
//  LikeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 29/04/2021.
//

import Foundation

class LikeViewModel: LikeManagerDelegate {
    
    let likeManager: LikeManager
    let userSession: User?
    var bookViewModels: [[BookViewModel]] = [[]]
    weak var delegate: LikeViewModelDelegate?
    weak var routingDelegate: LikeViewModelRoutingDelegate?
    let colsPerRow: Int = 3
    init(bookManager: BookManager, likeManager: LikeManager, userSession: User) {
        self.likeManager = likeManager
        self.userSession = userSession
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
        //TODO error retrieving Liked books
    }
    
    func likeFetchResult(_: LikeManager, books: [BookResult]) {
        self.resetResults(size: books.count)
        var colsCount = 0;
        var count = 0
        for item in books {
            bookViewModels[count].append(BookViewModel(bookResult: item))
            if colsCount == (self.colsPerRow - 1) {
                colsCount = 0
                count+=1
            }else{
                colsCount+=1
            }
        }
        self.delegate?.bookChanged(self)
    }
    
    func resetResults(size: Int){
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

}

protocol LikeViewModelDelegate: class {
    func bookChanged(_: LikeViewModel)
}

protocol LikeViewModelRoutingDelegate: class {
    func watchDetail(_: LikeViewModel, book: BookResult, userSession: User)
}
