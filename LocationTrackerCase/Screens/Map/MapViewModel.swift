//
//  MapViewModel.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import Foundation
import CoreLocation

class MapViewModel {
    var firstLocation: CLLocation?
    var currentLocation: CLLocation?
    var addMarker: ((CLLocation) -> Void)?
    let distanceBetweenMarksInMeter: Double = 20
    
    func locationUpdated(location: [CLLocation]) {
        currentLocation = location.last
        if firstLocation == nil {
            firstLocation = location.last
        }
        guard let firstLoc = firstLocation, let currentLoc = currentLocation else {
            return
        }
        if firstLoc.distance(from: currentLoc) >= distanceBetweenMarksInMeter {
            firstLocation = currentLoc
            self.addMarker?(currentLoc)
        }
    }
    
//    func getLocationInfo(location: CLLocation) -> CLPlacemark {
//        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, err in
//            guard let place = placeMarks?.last else {
//                return CLPlacemark()
//            }
//            return place
//        }
//    }
}
