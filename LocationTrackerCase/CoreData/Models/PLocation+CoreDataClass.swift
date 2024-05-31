//
//  PLocation+CoreDataClass.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//
//

import Foundation
import CoreData
import CoreLocation

@objc(PLocation)
public class PLocation: NSManagedObject {
    func pLocationToCLLocation() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
//    init(location: CLLocation) {
//        super.init()
//        self.latitude = location.coordinate.latitude
//        self.longitude = location.coordinate.longitude
//    }

}
