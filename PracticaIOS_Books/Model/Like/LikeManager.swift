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
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func addLike(book: Book, user: User) {
        self.findLikedByBookAndUser(user: user, book: book,
            completionHandler:{ datos in
                if datos.count != 0 {
                    let entity = NSEntityDescription.entity(forEntityName: self.LIKE_ENTITY, in: self.context)
                    let like = Like(entity: entity!, insertInto: self.context)
                    like.book = book
                    like.date = Date()
                    like.user = user
                    self.delegate?.likeAddResult(self, like: datos)
                }else{
                    self.deleteLike(like: datos.first!)
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
                    self.delegate?.likeError(self, message: "Couldn't delete like - not found")
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
                self.delegate?.likeFetchResult(self, like: datos)
            })
    }
    
    private func findLikedByBook(book: Book, completionHandler: @escaping ([Like]) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<Like>(entityName: LIKE_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "book == %@", book)
        self.fetchAsyncLikes(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
                completionHandler(datos)
            })
    }
    
    func findLikedByBookAndUser(user: User, book: Book, completionHandler: @escaping ([Like]) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<Like>(entityName: LIKE_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "user == %@ AND book == %@", user, book)
        self.fetchAsyncLikes(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
                completionHandler(datos)
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
    func likeAddResult(_:LikeManager, like:[Like])
    func likeError(_:LikeManager, message: String)
    func likeFetchResult(_:LikeManager, like:[Like])
}
