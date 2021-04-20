//
//  BookManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import Foundation

struct BookResult {
    var id: String?
    var title: String?
    var author: String?
    var description: String?
    var book_image: String?
    var created_date: String?
    var primary_isbn10: String?
}

class BookManager {
    
    
    let bookNYT: BookNYT
    let bookGoogle: BookGoogle
    weak var delegate: BookManagerDelegate?
    weak var detailDelegate: BookManagerDetailDelegate?
    weak var searchDelegate: BookManagerSearchDelegate?
    
    let sections = ["Libros relevantes", "Novedades", "Mis listas"]
    
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
                let res = Int.random(in: 0..<count)
                
                for book in lists[res].books {
                    let bookresult = BookResult(title: book.title, author: book.author, description: book.description, book_image: book.book_image, created_date: book.created_date, primary_isbn10: book.primary_isbn10)
                    bookResultArr.append(bookresult)
                }
                self.delegate?.bookChanged(self)
                completition2(bookResultArr)
            }
        })
    }
    
    func getBookDetail(isbn: String){
        let url = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(String(describing: isbn))&orderBy=newest&maxResults=1"
        bookGoogle.getResponse(str: url, completition2: { result in
            let r = result!.response?.items.first
            if let r = r {
                let bookresult = BookResult(id: r.id,title: r.volumeInfo.title, author: r.volumeInfo.authors![0], description: r.volumeInfo.description ?? r.volumeInfo.subtitle, book_image: r.volumeInfo.imageLinks.thumbnail, created_date: r.volumeInfo.publishedDate, primary_isbn10: isbn)
                self.detailDelegate?.bookDetail(self, bookResult: bookresult)
            }
            
        })
    }
    
    func searchBook(text: String){
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(String(describing: text))&orderBy=relevance"
        bookGoogle.getResponse(str: url, completition2: { result in
            var bookResultArr = [BookResult]()
            let lists = result?.response?.items
            if let lists = lists {              
                for item in lists {
                    let book = item.volumeInfo
                    let bookresult = BookResult(id: item.id, title: book.title, author: book.authors?[0] ?? "N/A", description: book.description, book_image: book.imageLinks.thumbnail, created_date: book.publishedDate, primary_isbn10: "")
                    bookResultArr.append(bookresult)
                }
            }
            self.searchDelegate?.searchBookResult(self, bookResult: bookResultArr)
        })
    }
    
    func getSections() -> [String]{
        return sections
    }
    
}

protocol BookManagerDelegate: class {
    func bookChanged(_: BookManager)
}
protocol BookManagerDetailDelegate: class {
    func bookDetail(_:BookManager, bookResult: BookResult)
}
protocol BookManagerSearchDelegate: class {
    func bookDetail(_:BookManager, bookResult: BookResult)
    func searchBookResult(_:BookManager, bookResult: [BookResult])
}
