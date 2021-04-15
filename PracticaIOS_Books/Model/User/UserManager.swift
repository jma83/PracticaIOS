//
//  UserManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 22/03/2021.
//

import UIKit
import CoreData

class UserManager{
    private let context: NSManagedObjectContext
    private let USER_ENTITY = "User"
    private let DOMAIN = "es.upsa.mimo.PracticaIOS-Books"

    weak var delegate: UserManagerDelegate?
    weak var initialDelegate: UserManagerStartDelegate?
    private let GENERIC_ERROR = "Error al enviar credenciales, intentalo de nuevo más tarde"
    private let ALREADY_EXISTS_ERROR = "Error el usuario ya existe"
    
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func fetchAsyncUsers(fetchAsyncRequest:NSFetchRequest<User>, completionHandler: @escaping ([User]) -> Void) -> Void {
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchAsyncRequest) { (result) in
            guard let users = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load users \(error)")
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
            self.delegate?.userCredentialError(self, error: GENERIC_ERROR)
        }
   }
    
    func fetchAllUsers(completionHandler: @escaping ([User]) -> Void) -> Void {
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        
        fetchAsyncUsers(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            print("count \(datos.count)")
            completionHandler(datos)
        })
    }
    
    func fetchByUsername(username:String, completionHandler: @escaping ([User]) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        fetchAsyncUsers(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            print("count \(datos.count)")
            completionHandler(datos)
        })
    }
    
    func checkLogin(username:String, password: String) -> Void {
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username,password)
        
        fetchAsyncUsers(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            print("count \(datos.count)")
            if datos.count > 0 {
                let u = datos.first!
                self.delegate?.userSession(self, didUserChange: u)
                do{
                    try self.storeUserSession(username: username, password: password)
                }catch {
                    self.delegate?.userCredentialError(self, error: self.GENERIC_ERROR)
                }
            }
        })
    }
     
    func saveUser(username:String,password:String,email:String,gender:Int,birthdate:Date,country:String) -> Void {
        
        self.fetchByUsername(username: username, completionHandler: { datos in
            if datos.count != 0 {
                self.delegate?.userCredentialError(self, error: self.ALREADY_EXISTS_ERROR)
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: self.USER_ENTITY, in: self.context)
            let user = User(entity: entity!, insertInto: self.context)

            user.username = username
            user.password = password
            user.email = email
            user.gender = Int16(gender)
            user.birthdate = birthdate
            user.country = country
            user.createDate = Date()

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            self.delegate?.userSession(self, didUserChange: user)
            
        })
        

        
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
    func userCredentialError(_: UserManager, error: String)
}

protocol UserManagerStartDelegate: class {
    func userSession(_: UserManager, didUserChange user: User)
}

enum MyError: Error {
    case runtimeError(String)
}
