//
//  User+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 22/03/2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var birthdate: Date?
    @NSManaged public var country: String?
    @NSManaged public var gender: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var updateDate: Date?

}

extension User : Identifiable {

}
