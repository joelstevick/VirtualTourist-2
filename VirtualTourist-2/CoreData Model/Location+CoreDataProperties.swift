//
//  Location+CoreDataProperties.swift
//  VirtualTourist-2
//
//  Created by Joel Stevick on 5/26/22.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var creationDate: Date?

}

extension Location : Identifiable {

}
