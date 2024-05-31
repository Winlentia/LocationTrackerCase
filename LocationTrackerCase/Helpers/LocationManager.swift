////
////  LocationManager.swift
////  LocationTrackerCase
////
////  Created by Winlentia on 31.05.2024.
////
//import Foundation
//import CoreLocation
//
//class LocationManager: NSObject {
//    
//    static let shared = LocationManager()
//    
//    let manager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        self.startManager()
//    }
//    
//    func startManager() {
//        manager.delegate = self
//        manager.requestAlwaysAuthorization()
//    }
//    
//    func requestLocationPermission() {
//        manager.requestAlwaysAuthorization()
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    didChan
//}
