//
//  UserManager.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 22/03/2021.
//

import UIKit
import CoreData

class UserManager{
    var datos = [NSManagedObject]()
    let userStr = "User"
    var context:NSManagedObjectContext
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
    
    func fetchAllUsers(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: userStr)
        
        do{
            datos = try context.fetch(fetchRequest)
        }catch let error {
            print("Error: \(error)")
        }
    }
    
    func getDatos() -> [NSManagedObject]{
        return datos
    }
    
    func saveUser(User u){
        let entity = NSEntityDescription.entity(forEntityName: userStr, in: context)
        if let e = entity{
            let user = NSManagedObject(entity: e, insertInto: context)
            
            user.setValue(u.username, forKey: "username")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            datos.append(user)
        }
    
    }
    
    func insertSampleData(){
        //plist
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: userStr)
        
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
