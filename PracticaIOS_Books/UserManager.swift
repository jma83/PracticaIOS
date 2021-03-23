//
//  UserManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 22/03/2021.
//

import UIKit
import CoreData

class UserManager{
    var datos:[User] = []
    var userSession:User
    var context:NSManagedObjectContext
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        userSession = User()
    }
    
    func fetchAllUsers() -> [User]{
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let asynchronousRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest){ (result) in
            guard let allUsers = result.finalResult else {
                if let error = result.operationError {
                    print("Couldn't load users \(error)")
                }
                
                return
            }
            self.datos = allUsers
        }
        
        do{
            try context.execute(asynchronousRequest)
        }catch let error {
            print("Error: \(error)")
        }
        
        return datos
    }
    
    func fetchByUsername(username:String) -> [User]{
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        do{
            datos = try context.fetch(fetchRequest)
        }catch let error {
            print("Error: \(error)")
        }
        
        return datos
    }
    
    func checkLogin(username:String, password: String) -> [User]{
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username,password)
        
        do{
            datos = try context.fetch(fetchRequest)
        }catch let error {
            print("Error: \(error)")
        }
        
        if datos.count > 0 {
            userSession = datos.first!
        }
        
        return datos
    }
     
    func getDatos() -> [NSManagedObject]{
        return datos
    }
    
    func saveUser(username:String,password:String,email:String,birthdate:Date,country:String){
        
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let object = User(entity: entity!, insertInto: context)
        object.username = username
        object.password = password
        object.email = email
        object.birthdate = birthdate
        object.country = country
        object.createDate = Date()

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let count = try! context.count(for: fetchRequest)
        print("count \(count)")
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        datos.append(object)
        
    
    }
    
    func insertSampleData(){
        //plist
        let fetchRequest = NSFetchRequest<User>()
        
        fetchRequest.predicate = NSPredicate(format: "username != nil")
        
        let count = try! context.count(for: fetchRequest)
        
        if count > 0 { return }
        
        let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
        
        let dataArray = NSArray(contentsOfFile: path!)!
        
        for d:Any in dataArray{
            //recorrer registros datos ejemplo
            let dicc = d as! NSDictionary
            
            //saveUser
        }
        
        
        
        
        
        
        
    }
}
