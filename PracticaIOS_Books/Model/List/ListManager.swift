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
    private let LIST_ENTITY = "User"
    private let DOMAIN = "es.upsa.mimo.PracticaIOS-Books"

    weak var delegate: ListManagerDelegate?
    private let GENERIC_ERROR = "Error al recuperar listas, intentalo de nuevo más tarde"
    private let ALREADY_EXISTS_ERROR = "Error la lista ya existe"    
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func fetchAsyncLists(fetchAsyncRequest:NSFetchRequest<List>, completionHandler: @escaping ([List]) -> Void) -> Void {
        
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
            self.delegate?.listError(self, error: GENERIC_ERROR)
        }
   }
    
    func fetchAllLists(completionHandler: @escaping ([List]) -> Void) -> Void {
        let fetchRequest = NSFetchRequest<List>(entityName: LIST_ENTITY)
        
        fetchAsyncLists(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            print("count \(datos.count)")
            completionHandler(datos)
        })
    }
    
    func fetchByName(nameList:String, completionHandler: @escaping ([List]) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<List>(entityName: LIST_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "name == %@", nameList)
        
        fetchAsyncLists(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            print("count \(datos.count)")
            completionHandler(datos)
        })
    }
     
    func createList(name: String) -> Void {
        
        self.fetchByName(nameList: name, completionHandler: { datos in
            if datos.count != 0 {
                self.delegate?.listError(self, error: self.ALREADY_EXISTS_ERROR)
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: self.LIST_ENTITY, in: self.context)
            let list = List(entity: entity!, insertInto: self.context)
            list.name = name
            list.createDate = Date()
            list.updateDate = Date()
            

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            self.delegate?.listUpdatedResult(self, didListChange: list)
            
        })
        
    }
    
    func deleteList(name: String) -> Void {
        
        self.fetchByName(nameList: name, completionHandler: { datos in
            if datos.count != 0 {
                self.delegate?.listError(self, error: self.ALREADY_EXISTS_ERROR)
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: self.LIST_ENTITY, in: self.context)
            let list = List(entity: entity!, insertInto: self.context)
            list.name = name
            list.createDate = Date()
            list.updateDate = Date()
            

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            self.delegate?.listUpdatedResult(self, didListChange: list)
            
        })
        
    }
   
}

protocol ListManagerDelegate: class {
    func listUpdatedResult(_: ListManager, didListChange list: List)
    func listError(_: ListManager, error: String)
}
