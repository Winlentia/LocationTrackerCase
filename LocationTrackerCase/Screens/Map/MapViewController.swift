//
//  ViewController.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let viewModel = MapViewModel()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        self.view.addSubview(mapView)
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupUI()
        bindViewModel()
        view.backgroundColor = .yellow
    }
    
    private func bindViewModel() {
        viewModel.addMarker = { [weak self] location in
            guard let self = self else { return }
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude:location.coordinate.longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = "Title"
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setupUI() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            viewModel.locationUpdated(location: locations)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Dont't Allow")
        // 1
        case .authorizedAlways:
            print("When user select option Change to Always Allow")
        locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("When user select option Allow While Using App or Allow Once")
            locationManager.startUpdatingLocation()
            // 2
        default:
            print("default")
        }
    }
}

