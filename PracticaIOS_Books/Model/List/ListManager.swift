//
//  ListManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//

import UIKit
import CoreData

struct ListResult {
    var name: String?
    var date: Date?
}

class ListManager{
    private let context: NSManagedObjectContext
    private let LIST_ENTITY = "List"
    private let DOMAIN = "es.upsa.mimo.PracticaIOS-Books"

    weak var delegate: ListManagerDelegate?
    weak var delegateAddTo: AddToListManagerDelegate?
    weak var delegateAdd: AddListManagerDelegate?
    weak var listDetailDelegate: ListDetailManagerDelegate?
    private let GENERIC_ERROR = "Error al recuperar listas, intentalo de nuevo más tarde"
    private let ALREADY_EXISTS_ERROR = "Error la lista ya existe"    
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    private func fetchAsyncLists(fetchAsyncRequest:NSFetchRequest<List>, completionHandler: @escaping ([List]) -> Void) -> Void {
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchAsyncRequest) { (result) in
            guard let users = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load lists \(error)")
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
            self.delegateAdd?.listError(self, error: GENERIC_ERROR)
        }
   }
    
    private func fetchByName(nameList:String, completionHandler: @escaping ([List]) -> Void){
        let fetchRequest = NSFetchRequest<List>(entityName: LIST_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "name == %@", nameList)
        
        fetchAsyncLists(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            completionHandler(datos)
        })
    }
    
    func fetchAllByUser(user: User) {
        let fetchRequest = NSFetchRequest<List>(entityName: LIST_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)
        
        fetchAsyncLists(fetchAsyncRequest: fetchRequest, completionHandler: { lists in
            print("count \(lists.count)")
            self.delegate?.listsResult(self, didListChange: lists)
            self.delegateAddTo?.listsResult(self, didListChange: lists)
        })
    }
     
    func createList(name: String, user: User) -> Void {
        
        self.fetchByName(nameList: name, completionHandler: { datos in
            if datos.count != 0 {
                self.delegateAdd?.listError(self, error: self.ALREADY_EXISTS_ERROR)
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: self.LIST_ENTITY, in: self.context)
            let list = List(entity: entity!, insertInto: self.context)
            list.name = name
            list.createDate = Date()
            list.updateDate = Date()
            list.user = user
            

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            self.delegateAdd?.listUpdatedResult(self, didListChange: list)
            
        })
        
    }
    
    func deleteList(list: List, user: User) -> Void {
        if list.user == user {
            self.context.delete(list)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
        }
        self.delegate?.deleteListResult(self)
    }
    
    func addBookToList(name: String, book: Book) {
        self.fetchByName(nameList: name, completionHandler: { datos in
            if datos.count != 0 {
                datos.first!.addToBooks(book)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
            }
        })
    }
    
    func removeBookFromList(name: String, book: Book) {
        self.fetchByName(nameList: name, completionHandler: { datos in
            if datos.count != 0 {
                datos.first!.removeFromBooks(book)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
            }
        })
    }
    
    func getBooksResultFromList(list: List) {
        var bookResultArr: [BookResult] = []
        if let books = list.books {
            for item in books {
                let book = item as! Book
                let bookresult = BookResult(id: book.id, title: book.title, author: book.author ??  "N/A", description: book.descrip, book_image: book.image, created_date: book.date, primary_isbn10: book.isbn)
                bookResultArr.append(bookresult)
            }
        }
        self.listDetailDelegate?.booksListResult(self, books: bookResultArr)
    }
   
}

protocol AddListManagerDelegate: class {
    func listUpdatedResult(_: ListManager, didListChange list: List)
    func listError(_: ListManager, error: String)
}

protocol AddToListManagerDelegate: class {
    func listsResult(_: ListManager, didListChange list: [List])
}

protocol ListManagerDelegate: class {
    func listsResult(_: ListManager, didListChange list: [List])
    func deleteListResult(_: ListManager)
}

protocol ListDetailManagerDelegate: class {
    func booksListResult(_: ListManager, books: [BookResult])
}
