//
//  UserManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 22/03/2021.
//

import UIKit
import CoreData

class UserManager{
    private var datos: [User] = []
    private let context: NSManagedObjectContext
    private let USER_ENTITY = "User"
    weak var delegate: UserManagerDelegate?
    
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func fetchAsyncUsers(fetchAsyncRequest:NSFetchRequest<User>) -> [User] {
        var output:[User] = []
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchAsyncRequest){ (result) in
            guard let users = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load users \(error)")
                }
                output = []
                return
            }
            output = users
        }
        
        do{
            try context.execute(asynchronousRequest)
        }catch let error {
            print("Error: \(error)")
        }
        
        return output
    }
    
    func fetchAllUsers() -> [User]{
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        
        //datos = fetchAsyncUsers(fetchAsyncRequest: fetchRequest)
        datos = try! context.fetch(fetchRequest)
        print("count \(datos.count)")
        return datos
    }
    
    func fetchByUsername(username:String) -> [User]{
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        //datos = fetchAsyncUsers(fetchAsyncRequest: fetchRequest)
        datos = try! context.fetch(fetchRequest)
        print("count \(datos.count)")
        return datos
    }
    
    func checkLogin(username:String, password: String) -> Bool{
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username,password)
        
        //datos = fetchAsyncUsers(fetchAsyncRequest: fetchRequest)
        datos = try! context.fetch(fetchRequest)
        print("count \(datos.count)")
        if datos.count > 0 {
            delegate?.userSession(self, didUserChange: datos.first!)
            return true
        }
        return false

    }
     
    func getDatos() -> [NSManagedObject]{
        return datos
    }
    
    func saveUser(username:String,password:String,email:String,gender:Int,birthdate:Date,country:String){
        
        let entity = NSEntityDescription.entity(forEntityName: USER_ENTITY, in: context)
        let object = User(entity: entity!, insertInto: context)
        object.username = username
        object.password = password
        object.email = email
        object.gender = Int16(gender)
        object.birthdate = birthdate
        object.country = country
        object.createDate = Date()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        delegate?.userSession(self, didUserChange: object)
        
        datos.append(object)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let count = try! context.fetch(fetchRequest)
        print("count \(count)")
        
    }
    
   
}

protocol UserManagerDelegate: class {
    func userSession(_: UserManager, didUserChange user: User)
}