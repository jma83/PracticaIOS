//
//  Book+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var date: String?
    @NSManaged public var descrip: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var isbn: String?
    @NSManaged public var title: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var like: NSSet?
    @NSManaged public var lists: NSSet?

}

// MARK: Generated accessors for comments
extension Book {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

// MARK: Generated accessors for like
extension Book {

    @objc(addLikeObject:)
    @NSManaged public func addToLike(_ value: Like)

    @objc(removeLikeObject:)
    @NSManaged public func removeFromLike(_ value: Like)

    @objc(addLike:)
    @NSManaged public func addToLike(_ values: NSSet)

    @objc(removeLike:)
    @NSManaged public func removeFromLike(_ values: NSSet)

}

// MARK: Generated accessors for lists
extension Book {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: List)

    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: List)

    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)

}

extension Book : Identifiable {

}
