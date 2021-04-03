//
//  BookManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation

class BookManager {
    var id: String?
    var title: String?
    var author: String?
    var description: String?
    var book_image: String?
    var created_date: String?
    var primary_isbn10: String?
    
    let bookNYT: BookNYT
    let bookGoogle: BookGoogle
    
    init() {
        bookNYT = BookNYT()
        bookGoogle = BookGoogle()
    }
    
    func getRelevantBooks(){
        bookNYT.getResponse(str: "https://api.nytimes.com/svc/books/v3/lists/overview.json", completition2: { result in
        })
    }
    
    func findBook(){
        
    }
    
    func getBookDetail(){
        
    }
    
    
}
