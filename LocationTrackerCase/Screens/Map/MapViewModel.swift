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
    
    func locationUpdated(location: [CLLocation]) {
        currentLocation = location.last
        if firstLocation == nil {
            firstLocation = location.last
        }
        guard let firstLoc = firstLocation, let currentLoc = currentLocation else {
            return
        }
        if firstLoc.distance(from: currentLoc) >= 100 {
            firstLocation = currentLoc
            self.addMarker?(currentLoc)
        }
    }
}
