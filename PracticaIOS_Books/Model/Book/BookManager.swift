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
    weak var likeDelegate: BookManagerLikeDelegate?
    weak var listDelegate: BookManagerListDelegate?
        
    init() {
        bookNYT = BookNYT()
        bookGoogle = BookGoogle()
    }
    
    func getRelevantBooks(){
        
        bookNYT.getResponse(str: "https://api.nytimes.com/svc/books/v3/lists/overview.json", completition2: { result in
            var bookResultArr: [[BookResult]] = []
            var sectionArr: [String] = []
            let lists = result?.response?.results.lists
            let maxSize = 3
            if let lists = lists {
                bookResultArr = [[BookResult]](repeating: [], count: maxSize)
                let arrItems = self.calcRandom(maxSize: maxSize, listSize: lists.count)
                
                var count = 0
                var internalCount = 0
                for itemList in lists {
                    if arrItems.contains(count){
                        for book in itemList.books {
                            let bookresult = BookResult(title: book.title, author: book.author, description: book.description, book_image: book.book_image, created_date: book.created_date, primary_isbn10: book.primary_isbn10)
                            bookResultArr[internalCount].append(bookresult)
                        }
                        internalCount+=1
                        sectionArr.append(itemList.list_name)
                    }
                    count+=1
                }
                self.delegate?.booksChanged(self, books: bookResultArr)
                self.delegate?.booksSectionChanged(self, sections: sectionArr)
            }
        })
    }
    
    func calcRandom(maxSize: Int, listSize: Int) -> [Int]{
        var arr:[Int] = []
        while maxSize > arr.count  {
            let result = Int.random(in: 0..<listSize)
            if !arr.contains(result){
                arr.append(result)
            }
        }
        return arr
    }
    
    func getBookDetail(isbn: String){
        let url = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(String(describing: isbn))&orderBy=newest&maxResults=1"
        bookGoogle.getResponse(str: url, completition2: { result in
            let r = result!.response?.items.first
            var bookresult: BookResult?
            if let r = r {
                bookresult = BookResult(id: r.id,title: r.volumeInfo.title, author: r.volumeInfo.authors?[0] ?? "N/A", description: r.volumeInfo.description ?? r.volumeInfo.subtitle, book_image: r.volumeInfo.imageLinks?.thumbnail, created_date: r.volumeInfo.publishedDate, primary_isbn10: isbn)
            }
            self.detailDelegate?.bookDetail(self, bookResult: bookresult)

            
        })
    }
    
    func searchBook(text: String){
        let text = encodeURLParam(param: text)
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(String(describing: text))&orderBy=relevance&maxResults=30"

        bookGoogle.getResponse(str: url, completition2: { result in
            var bookResultArr = [BookResult]()
            let lists = result?.response?.items
            if let lists = lists {              
                for item in lists {
                    let book = item.volumeInfo
                    let bookresult = BookResult(id: item.id, title: book.title, author: book.authors?[0] ?? "N/A", description: book.description, book_image: book.imageLinks?.thumbnail, created_date: book.publishedDate, primary_isbn10: "")
                    bookResultArr.append(bookresult)
                }
            }
            self.searchDelegate?.searchBookResult(self, bookResult: bookResultArr)
        })

    }

    func encodeURLParam(param: String) -> String {
        return param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
}

protocol BookManagerDelegate: class {
    func booksChanged(_: BookManager, books: [[BookResult]]?)
    func booksSectionChanged(_: BookManager, sections: [String]?)
}
protocol BookManagerLikeDelegate: class {
    func booksChanged(_: BookManager, books: [[BookResult]]?)
}
protocol BookManagerListDelegate: class {
    func booksChanged(_: BookManager, books: [[BookResult]]?)
}
protocol BookManagerDetailDelegate: class {
    func bookDetail(_: BookManager, bookResult: BookResult?)
}
protocol BookManagerSearchDelegate: class {
    func searchBookResult(_: BookManager, bookResult: [BookResult])
}
