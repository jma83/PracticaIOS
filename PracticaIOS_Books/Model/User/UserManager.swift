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
    private let DOMAIN = "es.upsa.mimo.PracticaIOS-Books"

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
            let u = datos.first!;
            delegate?.userSession(self, didUserChange: u)
            do{
                try self.storeUserSession(username: username, password: password)
            }catch {
                return false
            }
            
            return true
        }
        return false

    }
     
    func getDatos() -> [NSManagedObject]{
        return datos
    }
    
    func saveUser(username:String,password:String,email:String,gender:Int,birthdate:Date,country:String) -> Bool {
        
        let entity = NSEntityDescription.entity(forEntityName: USER_ENTITY, in: context)
        let user = User(entity: entity!, insertInto: context)
        user.username = username
        user.password = password
        user.email = email
        user.gender = Int16(gender)
        user.birthdate = birthdate
        user.country = country
        user.createDate = Date()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        delegate?.userSession(self, didUserChange: user)
        
        datos.append(user)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: USER_ENTITY)
        let count = try! context.fetch(fetchRequest)
        print("count \(count)")
        do{
            try self.storeUserSession(username: username, password: password)
        }catch{
            return false
        }
        return true

        
    }
    
    func storeUserSession(username: String, password: String) throws {
        let defaults = UserDefaults(suiteName: DOMAIN)
        
        defaults?.set(username, forKey: "Username")
        defaults?.set(password, forKey: "Pass")
    }
    
    func removeUserSession() throws {
        let defaults = UserDefaults(suiteName: DOMAIN)
        defaults?.removeSuite(named: DOMAIN)
    }
    
    func retrieveUserSession() throws {
        let defaults = UserDefaults(suiteName: DOMAIN)
        let username: String = defaults?.string(forKey: "Username") ?? ""
        let pass: String = defaults?.string(forKey: "Pass") ?? ""

        let _ = self.checkLogin(username: username, password: pass)
    }
   
}

protocol UserManagerDelegate: class {
    func userSession(_: UserManager, didUserChange user: User)
}

enum MyError: Error {
    case runtimeError(String)
}
