//
//  CommentManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit
import CoreData

struct CommentResult {
    var summary: String?
    var comment: String?
    var like: Bool?
    var date: Date?
}

class CommentManager{
    private let context: NSManagedObjectContext
    private let COMMENT_ENTITY = "Comment"

    weak var delegate: CommentManagerDelegate?
    weak var delegateAdd: AddCommentManagerDelegate?
    private let GENERIC_ERROR = "Error al recuperar comentarios, intentalo de nuevo más tarde"
    private let ALREADY_EXISTS_ERROR = "Error el comentario ya existe"
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func fetchAsyncComments(fetchAsyncRequest:NSFetchRequest<Comment>, completionHandler: @escaping ([Comment]) -> Void) -> Void {
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchAsyncRequest) { (result) in
            guard let users = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load comments \(error)")
                }
                completionHandler([])
                return
            }
            completionHandler(users)
        }
        
        do{
            try context.execute(asynchronousRequest)
        }catch let error {
            print("Error: \(error)")
            self.delegateAdd?.commentError(self, error: GENERIC_ERROR)
        }
   }
    
    func fetchCommentByUserAndBook(user: User, book: Book, completionHandler: @escaping ([Comment]) -> Void) -> Void {
        let fetchRequest = NSFetchRequest<Comment>(entityName: COMMENT_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "user == %@ AND book == %@", user, book)
        self.fetchAsyncComments(fetchAsyncRequest: fetchRequest, completionHandler: { comments in
            completionHandler(comments)
            
        })
    }
    
    
    func createComment(name: String, descrip: String, user: User, book: Book) -> Void {
        self.fetchCommentByUserAndBook(user: user, book: book, completionHandler: { comments in
            if comments.count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: self.COMMENT_ENTITY, in: self.context)
                let comment = Comment(entity: entity!, insertInto: self.context)
                comment.summary = name
                comment.comment = descrip
                comment.createDate = Date()
                comment.updateDate = Date()
                comment.user = user
                comment.book = book
                

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
                self.delegateAdd?.commentUpdatedResult(self, didListChange: comment)
                return
            }
            self.delegateAdd?.commentError(self, error: "You already have a comment in this book. The maximum is one per book.")
        })
        
    }
    
    func deleteComment(comment: Comment) -> Void {
        self.context.delete(comment)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        self.delegate?.commentDeleteResult(self, comment: comment)
    }
   
}

protocol AddCommentManagerDelegate: class {
    func commentUpdatedResult(_: CommentManager, didListChange comment: Comment)
    func commentError(_: CommentManager, error: String)
}

protocol CommentManagerDelegate: class {
    func commentDeleteResult(_: CommentManager, comment: Comment)
}
