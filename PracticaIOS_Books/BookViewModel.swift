//
//  BookViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class BookViewModel {
    let book: BookManager
    
    init(book: BookManager) {
        self.book = book
    }
    	
    var title: String {
        return book.title ?? ""
    }
    
    var description: String {
        return book.description ?? ""
    }
    
    var author: String {
        return book.author ?? ""
    }
    
}
