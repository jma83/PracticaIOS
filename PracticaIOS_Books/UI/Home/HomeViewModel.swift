//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel: BookManagerDelegate {

    let bookManager: BookManager
    var bookViewModels: [BookViewModel] = []
    weak var delegate: HomeViewModelDelegate?
    
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        self.bookManager.delegate = self
        self.bookManager.getRelevantBooks(completition2: { result in
            if let result = result {
                for item in result {
                    self.bookViewModels.append(BookViewModel(book: item))
                }
            }
        })
    }
    
    func bookChanged(_: BookManager) {
        delegate?.bookChanged(self.bookManager)
    }
    
}

protocol HomeViewModelDelegate: class {
    func bookChanged(_: BookManager)
}
