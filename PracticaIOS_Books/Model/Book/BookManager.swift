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
    weak var delegate: BookManagerHomeDelegate?
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
    
    func getRelevantBooks(){
        
        bookNYT.getResponse(str: "https://api.nytimes.com/svc/books/v3/lists/overview.json", completition2: { result in
            var bookResultArr: [[BookResult]] = []
            var sectionArr: [String] = []
            let maxSize = 3
            if let lists = result?.response?.results.lists {
                bookResultArr = [[BookResult]](repeating: [], count: maxSize)
                let arrItems = self.calcRandom(maxSize: maxSize, listSize: lists.count)
                
                var count = 0
                var internalCount = 0
                for itemList in lists {
                    if arrItems.contains(count){
                        for book in itemList.books {
                            let bookresult = BookResult(id: book.primary_isbn10 ,title: book.title, author: book.author, description: book.description, book_image: book.book_image, created_date: book.created_date, primary_isbn10: book.primary_isbn10)
                            bookResultArr[internalCount].append(bookresult)
                        }
                        internalCount+=1
                        sectionArr.append(itemList.list_name)
                    }
                    count+=1
                }
                self.delegate?.homeBooksResult(self, books: bookResultArr)
                self.delegate?.booksSectionResult(self, sections: sectionArr)
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
    
    func getBookDetail(isbn: String, id: String){
        let url = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(String(describing: isbn))&orderBy=newest&maxResults=1"
        bookGoogle.getResponse(str: url, completition2: { result in
            var bookresult: BookResult?
            if let r = result!.response?.items.first {
                bookresult = BookResult(id: r.id,title: r.volumeInfo.title, author: r.volumeInfo.authors?[0] ?? "N/A", description: r.volumeInfo.description ?? r.volumeInfo.subtitle, book_image: r.volumeInfo.imageLinks?.thumbnail, created_date: r.volumeInfo.publishedDate, primary_isbn10: isbn)
            }
            
            self.detailDelegate?.bookResultDetail(self, bookResult: bookresult)
            
            let id = (bookresult?.id ?? bookresult?.primary_isbn10) ?? id
            self.fetchById(id: id, completionHandler: { books in
                if books.count > 0 {
                    self.detailDelegate?.bookDetail(self, book: books.first)
                }
            })
            
            
        })
    }
    
    func searchBook(text: String){
        let text = encodeURLParam(param: text)
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(String(describing: text))&orderBy=relevance&maxResults=30"

        bookGoogle.getResponse(str: url, completition2: { result in
            var bookResultArr = [BookResult]()
            if let lists = result?.response?.items {
                for item in lists {
                    let book = item.volumeInfo
                    let bookresult = BookResult(id: item.id, title: book.title, author: book.authors?[0] ?? "N/A", description: book.description, book_image: book.imageLinks?.thumbnail, created_date: book.publishedDate, primary_isbn10: book.industryIdentifiers?[0]?.identifier ?? "")
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
            print("count \(datos.count)")
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
