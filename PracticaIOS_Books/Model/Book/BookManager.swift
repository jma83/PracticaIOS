//
//  BookManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation

class BookManager {
    struct BookResult {
        var title: String?
        var author: String?
        var description: String?
        var book_image: String?
        var created_date: String?
        var primary_isbn10: String?
    }
    
    let bookNYT: BookNYT
    let bookGoogle: BookGoogle
    weak var delegate: BookManagerDelegate?
    
    init() {
        bookNYT = BookNYT()
        bookGoogle = BookGoogle()
    }
    
    func getRelevantBooks(completition2: @escaping ([BookResult]?) -> ()){
        
        bookNYT.getResponse(str: "https://api.nytimes.com/svc/books/v3/lists/overview.json", completition2: { result in
            var bookResultArr = [BookResult]()
            let lists = result?.response?.results.lists
            if let lists = lists {
                let count = lists.count
                let res=Int.random(in: 0..<count)
                
                for book in lists[res].books {
                    let bookresult = BookResult(title: book.title, author: book.author, description: book.description, book_image: book.book_image, created_date: book.created_date, primary_isbn10: book.primary_isbn10)
                    bookResultArr.append(bookresult)
                }
                self.delegate?.bookChanged(self)
                completition2(bookResultArr)
            }
        })
    }
    
    func findBook(){
        
    }
    
    func getBookDetail(){
        
    }
    
    
    
}

protocol BookManagerDelegate: class {
    func bookChanged(_: BookManager)
}
