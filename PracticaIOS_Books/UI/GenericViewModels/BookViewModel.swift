//
//  BookViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class BookViewModel {
    
    
    let bookResult: BookResult
    
    
    
    init(bookResult: BookResult) {
        self.bookResult = bookResult
    }

    	
    var title: String {
        return bookResult.title ?? ""
    }
    
    var description: String {
        return bookResult.description ?? ""
    }
    
    var author: String {
        return bookResult.author ?? ""
    }
    
    var book: Book?

    
}
