//
//  List+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 25/04/2021.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var updateDate: Date?
    @NSManaged public var relationship: Book?
    @NSManaged public var relationship1: User?

}

extension List : Identifiable {

}
