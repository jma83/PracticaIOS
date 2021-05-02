//
//  User+CoreDataProperties.swift
//  PracticaIOS_Books
//
//  Created by Javier Martinez on 02/05/2021.
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
    @NSManaged public var lists: NSSet?
    @NSManaged public var likes: NSSet?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for lists
extension User {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: List)

    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: List)

    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)

}

// MARK: Generated accessors for likes
extension User {

    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: Like)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: Like)

    @objc(addLikes:)
    @NSManaged public func addToLikes(_ values: NSSet)

    @objc(removeLikes:)
    @NSManaged public func removeFromLikes(_ values: NSSet)

}

// MARK: Generated accessors for comments
extension User {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension User : Identifiable {

}
