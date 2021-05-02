//
//  Comment+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var comment: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var like: Bool
    @NSManaged public var summary: String?
    @NSManaged public var updateDate: Date?
    @NSManaged public var book: Book?
    @NSManaged public var user: User?

}

extension Comment : Identifiable {

}
