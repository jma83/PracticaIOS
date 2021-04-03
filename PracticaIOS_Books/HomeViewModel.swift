//
//  HomeViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class HomeViewModel {
    let bookManager: BookManager
    var bookViewModels: [BookViewModel] = []
    
    init(bookManager: BookManager) {
        self.bookManager = bookManager
        
        self.bookManager.getRelevantBooks()
        
    }
}
