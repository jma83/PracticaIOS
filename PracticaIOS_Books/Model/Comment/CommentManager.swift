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
    
    
    
    
    func createComment(name: String, user: User, book: Book) -> Void {
        
        let entity = NSEntityDescription.entity(forEntityName: self.COMMENT_ENTITY, in: self.context)
        let comment = Comment(entity: entity!, insertInto: self.context)
        comment.summary = name
        comment.createDate = Date()
        comment.updateDate = Date()
        comment.user = user
        comment.book = book
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        self.delegateAdd?.commentUpdatedResult(self, didListChange: comment)
            
        
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
    func commentsResult(_: CommentManager, didCommentChange comment: Comment)
    func commentDeleteResult(_: CommentManager, comment: Comment)
}
