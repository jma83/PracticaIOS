//
//  User+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 21/04/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var birthdate: Date?
    @NSManaged public var country: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var email: String?
    @NSManaged public var gender: Int16
    @NSManaged public var password: String?
    @NSManaged public var updateDate: Date?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
