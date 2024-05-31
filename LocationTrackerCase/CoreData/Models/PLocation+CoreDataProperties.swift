//
//  PLocation+CoreDataProperties.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//
//

import Foundation
import CoreData


extension PLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PLocation> {
        return NSFetchRequest<PLocation>(entityName: "PLocation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
