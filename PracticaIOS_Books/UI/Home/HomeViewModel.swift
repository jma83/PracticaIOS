//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel: BookManagerDelegate {

    let bookManager: BookManager
    var bookViewModels: [[BookViewModel]] = [ [], [], [] ]
    weak var delegate: HomeViewModelDelegate?
    
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        self.bookManager.delegate = self
        self.bookManager.getRelevantBooks(completition2: { result in
            if let result = result {
                var count = 0
                while count <= 2 {
                    for item in result {
                        self.bookViewModels[count].append(BookViewModel(book: item))
                    }
                    count+=1
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
