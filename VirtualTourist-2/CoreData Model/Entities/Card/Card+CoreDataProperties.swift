//
//  Card+CoreDataProperties.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/28/22.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    // MARK: - NSManaged properties
    @NSManaged public var id: String
    @NSManaged public var location: Location?
    @NSManaged public var storedImage: Data?

}

extension Card : Identifiable {
}

