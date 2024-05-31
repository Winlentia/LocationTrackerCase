//
//  CustomMapView.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import Foundation
import MapKit

class CustomMapView: MKMapView {
    func addAnnotation(location: CLLocation) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude:location.coordinate.longitude)
        annotation.coordinate = centerCoordinate
        
        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, err in
            if let _ = err {
                annotation.title = "Unknown"
                self.addAnnotation(annotation)
            } else {
                annotation.title = "\(placeMarks?.last?.name) \(placeMarks?.last?.thoroughfare)"
                self.addAnnotation(annotation)
            }
        }
    }
    
    func focusTo(location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        self.setRegion(region, animated: true)
    }
}
