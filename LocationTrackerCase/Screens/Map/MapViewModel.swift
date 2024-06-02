//
//  MapViewModel.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import Foundation
import CoreLocation

final class MapViewModel {
    var addMarker: ((CLLocation) -> Void)?
    var removeAllMarkers: (() -> Void)?
    
    var firstLocation: CLLocation?
    var currentLocation: CLLocation?
    let distanceBetweenMarksInMeter: Double = 20
    var isTrackingActive: Bool = true
    
    func controlCoreDataForMarks() -> [CLLocation] {
        return CoreDataManager.shared.getAllPLocations().map({$0.pLocationToCLLocation()})
    }
    
    func locationUpdated(location: [CLLocation]) {
        currentLocation = location.last
        if !isTrackingActive {
            firstLocation = nil
            return
        }
        if firstLocation == nil {
            firstLocation = location.last
        }
        guard let firstLoc = firstLocation, let currentLoc = currentLocation else {
            return
        }
        if firstLoc.distance(from: currentLoc) >= distanceBetweenMarksInMeter {
            firstLocation = currentLoc
            CoreDataManager.shared.createPLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
            self.addMarker?(currentLoc)
        }
    }
    
    func resetMarkers() {
        CoreDataManager.shared.deleteAllPlocations()
        removeAllMarkers?()
    }
}
