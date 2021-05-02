//
//  List+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
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
    @NSManaged public var books: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for books
extension List {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension List : Identifiable {

}
