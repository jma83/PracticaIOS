//
//  Like+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//
//

import Foundation
import CoreData


extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var date: Date?
    @NSManaged public var book: Book?
    @NSManaged public var user: User?

}

extension Like : Identifiable {

}
