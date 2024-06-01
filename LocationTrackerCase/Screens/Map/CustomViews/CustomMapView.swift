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
        addAnnotation(annotation)
        
//        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, err in
//            if let _ = err {
//                annotation.title = "Unknown"
//                self.addAnnotation(annotation)
//            } else {
//                annotation.title = "\(placeMarks?.last?.name) \(placeMarks?.last?.thoroughfare)"
//                self.addAnnotation(annotation)
//            }
//        }
    }
    
    func focusTo(location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        self.setRegion(region, animated: true)
    }
    
    func addCustomAnnotationView(view: MKAnnotationView) {
        guard let latitude = view.annotation?.coordinate.latitude, let longitude = view.annotation?.coordinate.longitude else { return }
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placeMarks, err in
            var title = ""
            if let _ = err {
                title = "Unknown"
            } else {
                print(placeMarks?.last)
                if let name = placeMarks?.last?.name,
                let thoroughfare = placeMarks?.last?.thoroughfare {
                    title = "\(name) \n \(thoroughfare)"
                }
            }
            
            let customView = AnnotationPopupView()
            
            view.addSubview(customView)
            customView.label.text = title
            
            customView.snp.makeConstraints { make in
                make.bottom.equalTo(view.snp.bottom).inset(80)
                make.centerX.equalToSuperview()
                make.width.equalTo(180)
                make.height.equalTo(50)
            }
        }
    }
    
    func removeAllAnnotations() {
        removeAnnotations(self.annotations)
    }
}
