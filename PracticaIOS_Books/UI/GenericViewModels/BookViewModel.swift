//
//  BookViewModel.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 04/04/2021.
//

import Foundation

class BookViewModel {
    
    
    let book: BookResult
    
    init(book: BookResult) {
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
    
    func getBookObj() -> Book {
        let book = Book()
        book.author = self.book.author
        book.isbn = self.book.primary_isbn10
        book.descrip = self.book.description
        book.title = self.book.title
        book.date = self.book.created_date
        book.image = self.book.book_image
        
        return book
    }
    
}
