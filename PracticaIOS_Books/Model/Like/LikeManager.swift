//
//  LikeManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//

import UIKit
import CoreData

struct LikeResult {
    var like: Bool?
}

class LikeManager {
    private let LIKE_ENTITY = "Like"
    private let context: NSManagedObjectContext
    weak var delegate: LikeManagerDelegate?
    weak var detailDelegate: LikeManagerDetailDelegate?
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func manageLike(book: Book, user: User) {
        self.findLikedByBookAndUser(user: user, book: book,
            completionHandler:{ datos in
                if datos.count == 0 {
                    let entity = NSEntityDescription.entity(forEntityName: self.LIKE_ENTITY, in: self.context)
                    let like = Like(entity: entity!, insertInto: self.context)
                    like.book = book
                    like.user = user
                    like.date = Date()
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.saveContext()
                    self.detailDelegate?.likeAddResult(self, checkLike: true)
                }else{
                    self.deleteLike(like: datos.first!)
                    self.detailDelegate?.likeAddResult(self, checkLike: false)
                }
            })
    }
    
    func deleteLikeByProps(book: Book, user: User) {
        self.findLikedByBookAndUser(user: user, book: book,
            completionHandler:{ datos in
                if datos.count > 0 {
                    self.context.delete(datos.first!)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.saveContext()
                }else{
                    self.detailDelegate?.likeError(self, message: "Couldn't delete like - not found")
                }
            })
    }
    
    func deleteLike(like: Like) {
        self.context.delete(like)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
    }
    
    func findLikedByUser(user: User){
        let fetchRequest = NSFetchRequest<Like>(entityName: LIKE_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)
        self.fetchAsyncLikes(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
                var bookResultArr = [BookResult]()
                for item in datos {
                    let book = item.book! as Book

                    let bookresult = BookResult(id: book.id, title: book.title, author: book.author ?? "N/A", description: book.description, book_image: book.image, created_date: book.date, primary_isbn10: book.isbn)
                    bookResultArr.append(bookresult)
                    
                }
            self.delegate?.likeFetchResult(self, books: bookResultArr)
            })
    }
    
    private func findLikedByBook(book: Book, completionHandler: @escaping ([Like]) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<Like>(entityName: LIKE_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "book == %@", book)
        self.fetchAsyncLikes(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
                completionHandler(datos)
            })
    }
    
    private func findLikedByBookAndUser(user: User, book: Book, completionHandler: @escaping ([Like]) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<Like>(entityName: LIKE_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "user == %@ AND book == %@", user, book)
        self.fetchAsyncLikes(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
                completionHandler(datos)
            })
    }
    
    func checkLikedByBookAndUser(user: User, book: Book) {
        self.findLikedByBookAndUser(user: user, book: book, completionHandler: { books in
            if books.count > 0 {
                self.detailDelegate?.likeCheckBook(self, checkLike: true)
            }else{
                self.detailDelegate?.likeCheckBook(self, checkLike: false)
            }
        })
    }
    
    func fetchAsyncLikes(fetchAsyncRequest:NSFetchRequest<Like>, completionHandler: @escaping ([Like]) -> Void) -> Void {
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchAsyncRequest) { (result) in
            guard let likes = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load books \(error)")
                }
                completionHandler([])
                return
            }
            completionHandler(likes)
        }
        
        do{
            try context.execute(asynchronousRequest)
        }catch let error {
            print("Error: \(error)")
        }
    }
    
}

protocol LikeManagerDelegate: class {
    func likeError(_:LikeManager, message: String)
    func likeFetchResult(_:LikeManager, books: [BookResult])
    
}

protocol LikeManagerDetailDelegate: class {
    func likeAddResult(_:LikeManager, checkLike: Bool)
    func likeCheckBook(_:LikeManager, checkLike: Bool)
    func likeError(_:LikeManager, message: String)
}
