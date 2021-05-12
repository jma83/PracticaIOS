//
//  BookManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 03/04/2021.
//

import UIKit
import CoreData

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
    weak var homeDelegate: BookManagerHomeDelegate?
    weak var detailDelegate: BookManagerDetailDelegate?
    weak var searchDelegate: BookManagerSearchDelegate?
    weak var likeDelegate: BookManagerLikeDelegate?
    weak var listDelegate: BookManagerListDelegate?
    private let context: NSManagedObjectContext
    private let BOOK_ENTITY = "Book"
        
    init() {
        bookNYT = BookNYT()
        bookGoogle = BookGoogle()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func getRelevantBooks(rowsSize: Int){
        self.bookNYT.getResponse(str: self.getSuggestedURL(), completition2: { result in
            let maxSize = rowsSize
            if let result = result?.response?.results {
                self.bookNYT.convertResponse(result: result, maxSize: maxSize, completion: { (bookResultArr, sectionArr)  in
                    self.homeDelegate?.homeBooksResult(self, books: bookResultArr)
                    self.homeDelegate?.booksSectionResult(self, sections: sectionArr)
                })
            }
        })
    }
    
    func getBookDetail(isbn: String, id: String){
        let maxSize = 1
        var id = id
        
        let url = self.getDetailURL(isbn: isbn, maxResults: maxSize)
        bookGoogle.getResponse(str: url, completition2: { result in
            if let response = result!.response {
                self.bookGoogle.convertResponse(response: response, maxSize: maxSize, completion: { bookResultArr in
                    let bookResult = bookResultArr.first
                    self.detailDelegate?.bookResultDetail(self, bookResult: bookResult)
                    
                    id = (bookResult?.id ?? bookResult?.primary_isbn10) ?? id
                })
            }else{
                self.detailDelegate?.bookResultDetail(self, bookResult: nil)
            }
            self.fetchById(id: id, completionHandler: { books in
                if books.count > 0 {
                    self.detailDelegate?.bookDetail(self, book: books.first)
                }
            })
        })
    }
    
    func searchBook(text: String, maxResults: Int){
        let text = encodeURLParam(param: text)
        let url = self.getSearchURL(text: text, maxResults: maxResults)

        self.bookGoogle.getResponse(str: url, completition2: { result in
            if let response = result?.response {
                self.bookGoogle.convertResponse(response: response, maxSize: maxResults, completion: { bookResultArr in
                    self.searchDelegate?.searchBookResult(self, bookResult: bookResultArr)
                })
            }
        })

    }
    
    func formatBookRows(bookResult: [BookResult], maxPerRow: Int,completionHandler: @escaping ([[BookResult]]) -> Void) -> Void{
        var countRows = bookResult.count/maxPerRow
        if bookResult.count % maxPerRow != 0 && bookResult.count > 0 {
            countRows+=1
        }
        var booksArr = [[BookResult]](repeating: [], count: countRows)
        var colsCount = 0;
        var count = 0
        
        for item in bookResult {
            booksArr[count].append(item)
            if colsCount == (maxPerRow - 1) {
                colsCount = 0
                count+=1
            }else{
                colsCount+=1
            }
        }
        completionHandler(booksArr)
    }

    private func encodeURLParam(param: String) -> String {
        return param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    private func getDetailURL(isbn: String, maxResults: Int) -> String {
        return "https://www.googleapis.com/books/v1/volumes?q=isbn:\(String(describing: isbn))&orderBy=newest&maxResults=\(String(describing: maxResults))"
    }
    
    private func getSearchURL(text: String, maxResults: Int) -> String{
        return "https://www.googleapis.com/books/v1/volumes?q=\(String(describing: text))&orderBy=relevance&maxResults=\(String(describing: maxResults))"
    }
    
    private func getSuggestedURL() -> String {
        return "https://api.nytimes.com/svc/books/v3/lists/overview.json"
    }
    
}

extension BookManager {
    
    private func fetchAsyncBooks(fetchAsyncRequest:NSFetchRequest<Book>, completionHandler: @escaping ([Book]) -> Void) -> Void {
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchAsyncRequest) { (result) in
            guard let books = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load books \(error)")
                }
                completionHandler([])
                return
            }
            completionHandler(books)
        }
        
        do{
            try context.execute(asynchronousRequest)
        }catch let error {
            print("Error: \(error)")
        }
    }
    
    private func fetchById(id: String, completionHandler: @escaping ([Book]) -> Void) -> Void {
        let fetchRequest = NSFetchRequest<Book>(entityName: BOOK_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        fetchAsyncBooks(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            completionHandler(datos)
        })
    }
    
    func createBook(book: BookResult, completionHandler: @escaping (Book) -> Void) -> Void {
        let id = (book.id ?? book.primary_isbn10) ?? ""
        self.fetchById(id: id, completionHandler: { datos in
            if datos.count != 0 {
                completionHandler(datos.first!)
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: self.BOOK_ENTITY, in: self.context)
            let newbook = Book(entity: entity!, insertInto: self.context)
            
            newbook.id = book.id
            newbook.title = book.title
            newbook.descrip = book.description
            newbook.author = book.author
            newbook.date = book.created_date
            newbook.image = book.book_image
            newbook.isbn = book.primary_isbn10
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            completionHandler(newbook)
            
        })
    }
    
    func getBook(book: BookResult, completionHandler: @escaping (Book?) -> Void) -> Void {
        let id = (book.id ?? book.primary_isbn10) ?? ""
        self.fetchById(id: id, completionHandler: { datos in
            if datos.count != 0 {
                completionHandler(datos.first!)
                return
            }
            
            completionHandler(nil)
            
        })
    }
    
}



protocol BookManagerHomeDelegate: class {
    func homeBooksResult(_: BookManager, books: [[BookResult]]?)
    func booksSectionResult(_: BookManager, sections: [String]?)
}
protocol BookManagerLikeDelegate: class {
    func booksChanged(_: BookManager, books: [[BookResult]]?)
}
protocol BookManagerListDelegate: class {
    func booksChanged(_: BookManager, books: [[BookResult]]?)
}
protocol BookManagerDetailDelegate: class {
    func bookResultDetail(_: BookManager, bookResult: BookResult?)
    func bookDetail(_: BookManager, book: Book?)
}
protocol BookManagerSearchDelegate: class {
    func searchBookResult(_: BookManager, bookResult: [BookResult])
}
