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
    let USERNAME_PATTERN = "[A-Z0-9a-z._]{2,20}"
    let PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{5,30}$"
    let EMAIL_PATTERN = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
    let COUNTRY_PATTERN = "/^[ñA-Za-z _]*[ñA-Za-z][ñA-Za-z _]{2,50}*$/"

    
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
    
    func saveUser(username:String,password:String,email:String,birthdate:NSDate,country:String){
        
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let object = User(entity: entity!, insertInto: context)
        object.username = username
        object.password = password
        object.email = email
        object.birthdate = birthdate as Date
        object.country = country
        object.createDate = Date()

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let count = try! context.count(for: fetchRequest)
        print("count \(count)")
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        datos.append(object)
        
    
    }
    
    func validateUsername(username: String?) -> Bool{
        if let username = username {
            return validateStringFormat(regex: USERNAME_PATTERN, value: username )
        }
        
        return false
    }
    
    func validatePassword(password: String?) -> Bool{
        if let password = password {
            return validateStringFormat(regex: PASSWORD_PATTERN, value: password )
        }
        
        return false
    }
    
    func validateEmail(email: String?) -> Bool{
        if let email = email {
            return validateStringFormat(regex: EMAIL_PATTERN, value: email )
        }
        
        return false
    }
    
    func validateCountry(country: String?) -> Bool{
        if let country = country {
            return validateStringFormat(regex: COUNTRY_PATTERN, value: country )
        }
        
        return false
    }
    
    func validateDate(date: NSDate?) -> Bool{
        if let date = date {
            let yearComp = DateComponents(year: -18)
            let minimumDate = Calendar.current.date(byAdding: yearComp, to: Date())
            if minimumDate! <= date as Date{
                return true
            }
            
        }
        
        return false
    }
    
    
    func validateStringFormat(regex: String, value: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let check = predicate.evaluate(with: value)
        
        return check
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
