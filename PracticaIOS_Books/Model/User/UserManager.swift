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
    private let DOMAIN = "es.upsa.mimo.PracticaIOSBooks"

    weak var delegate: UserManagerDelegate?
    weak var initialDelegate: UserManagerStartDelegate?
    weak var homeDelegate: UserHomeManagerDelegate?
    private let GENERIC_ERROR = "Error al enviar credenciales, intentalo de nuevo más tarde"
    private let ALREADY_EXISTS_ERROR = "Error el usuario ya existe"
    private let INVALID_CREDENTIALS_ERROR = "Error. El usuario o la contraseña no coinciden"
    
    
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
                let token = self.generateUserToken(username: u.username!)
                u.setValue(token, forKey: "userToken")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
                self.delegate?.userSession(self, didUserChange: u)
                do{
                    try self.storeUserSession(username: username, userToken: token)
                }catch {
                    self.delegate?.userCredentialError(self, error: self.GENERIC_ERROR)
                }
            }else{
                self.delegate?.userCredentialError(self, error: self.INVALID_CREDENTIALS_ERROR)
            }
        })
    }
    
    func checkSession(username:String, userToken: String, completionHandler: @escaping (User?) -> Void) -> Void {
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND userToken == %@", username, userToken)
        
        fetchAsyncUsers(fetchAsyncRequest: fetchRequest, completionHandler: { datos in
            if datos.count > 0 {
                completionHandler(datos.first!)
            }else{
                completionHandler(nil)
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
            let token = self.generateUserToken(username: username)
            user.userToken = token

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            
            do{
                try self.storeUserSession(username: username, userToken: token)
            }catch {
                self.delegate?.userCredentialError(self, error: self.GENERIC_ERROR)
            }
            self.delegate?.userSession(self, didUserChange: user)
            
        })
        

        
    }
    
    private func generateUserToken(username: String) -> String{
        let date = Date()
        let random = Int.random(in: 0...9999)
        let str = "\(username)\(date)\(random)"
        let utf8str = str.data(using: .utf8)

        if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
            return base64Encoded
        }
        return ""
    }
    
    func storeUserSession(username: String, userToken: String) throws {
        let defaults = UserDefaults.init(suiteName: DOMAIN)
        
        defaults?.set(username, forKey: "Username")
        defaults?.set(userToken, forKey: "UserToken")
    }
    
    func removeUserSession() {
        let defaults = UserDefaults(suiteName: DOMAIN)
        defaults?.removeObject(forKey: "Username")
        defaults?.removeObject(forKey:"UserToken")
        defaults?.removeSuite(named: DOMAIN)
        self.homeDelegate?.userLogoutResult(self)
    }
    
    func retrieveUserSession(initial: Bool) {
        let defaults = UserDefaults(suiteName: DOMAIN)
        let username: String = defaults?.string(forKey: "Username") ?? ""
        let userToken: String = defaults?.string(forKey: "UserToken") ?? ""

        self.checkSession(username: username, userToken: userToken, completionHandler: { user in
            if let user = user  {
                self.initialDelegate?.userSession(self, didUserChange: user)
            }else{
                self.initialDelegate?.userSessionError(self, message: "Error user not found")
            }
        })
    }
    
   
}

protocol UserManagerDelegate: class {
    func userSession(_: UserManager, didUserChange user: User)
    func userCredentialError(_: UserManager, error: String)
}

protocol UserHomeManagerDelegate: class {
    func userLogoutResult(_: UserManager)
}

protocol UserManagerStartDelegate: class {
    func userSession(_: UserManager, didUserChange user: User)
    func userSessionError(_: UserManager, message: String)
}

enum MyError: Error {
    case runtimeError(String)
}
