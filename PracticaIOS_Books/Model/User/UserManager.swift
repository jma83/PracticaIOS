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
    private let DOMAIN = "com.mylibrary.keys.mykey"

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
            do{
                try self.storeUserSession(user: u)
            }catch {
                return false
            }
            delegate?.userSession(self, didUserChange: u)
            
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
    
    func storeUserSession(user: User) throws {
        let defaults = UserDefaults.init(suiteName: DOMAIN)
        defaults?.set(user.username, forKey: "Username")
        let key = user.password
        let tag = DOMAIN.data(using: .utf8)!
        let addquery: [String: Any] = [kSecClass as String: kSecClassKey, kSecAttrApplicationTag as String: tag, kSecValueRef as String: key!]
        
        let status = SecItemAdd(addquery as CFDictionary, nil)
        guard status == errSecSuccess else { throw MyError.runtimeError("Error storing user info") }
    }
    
    func removeUserSession() throws {
        let defaults = UserDefaults.init(suiteName: DOMAIN)
        defaults?.removeSuite(named: DOMAIN)
        let query = self.getDomainQuery()
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw MyError.runtimeError("Error removing user session")
        }
    }
    
    func retriveUserSession() throws -> (String,Int){
        let defaults = UserDefaults.init(suiteName: DOMAIN)
        let username: String = defaults?.string(forKey: "Username") ?? ""
        let query = self.getDomainQuery()
        
        var it: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &it)
        guard status == errSecSuccess else { throw MyError.runtimeError("Error removing user session") }
        let key = it as! SecKey
        return (username,key.hashValue)
    }
    
    func getDomainQuery() -> [String: Any]{
        let tag = DOMAIN.data(using: .utf8)!
        return [kSecClass as String: kSecClassKey,kSecAttrApplicationTag as String: tag, kSecAttrKeyType as String: kSecAttrKeyTypeRSA, kSecReturnRef as String: true]
    }
   
}

protocol UserManagerDelegate: class {
    func userSession(_: UserManager, didUserChange user: User)
}

enum MyError: Error {
    case runtimeError(String)
}
