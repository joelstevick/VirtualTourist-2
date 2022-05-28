//
//  Location+CoreDataProperties.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/28/22.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var cards: NSOrderedSet?

}

// MARK: Generated accessors for cards
extension Location {

    @objc(insertObject:inCardsAtIndex:)
    @NSManaged public func insertIntoCards(_ value: Card, at idx: Int)

    @objc(removeObjectFromCardsAtIndex:)
    @NSManaged public func removeFromCards(at idx: Int)

    @objc(insertCards:atIndexes:)
    @NSManaged public func insertIntoCards(_ values: [Card], at indexes: NSIndexSet)

    @objc(removeCardsAtIndexes:)
    @NSManaged public func removeFromCards(at indexes: NSIndexSet)

    @objc(replaceObjectInCardsAtIndex:withObject:)
    @NSManaged public func replaceCards(at idx: Int, with value: Card)

    @objc(replaceCardsAtIndexes:withCards:)
    @NSManaged public func replaceCards(at indexes: NSIndexSet, with values: [Card])

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSOrderedSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSOrderedSet)

}

extension Location : Identifiable {

}
