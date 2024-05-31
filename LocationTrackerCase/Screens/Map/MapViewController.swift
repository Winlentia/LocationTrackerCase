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
    
    lazy var mapView: CustomMapView = {
        let mapView = CustomMapView()
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        return mapView
    }()
    
    lazy var showCurrentLocationButton: LocationButton = {
        let button = LocationButton()
        view.addSubview(button)
        button.addTarget(self, action: #selector(showCurrentLocationPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        controlDbMarksAndPinThem()
        setupLocationManager()
        setupUI()
        bindViewModel()
        view.backgroundColor = .yellow
    }
    
    private func bindViewModel() {
        viewModel.addMarker = { [weak self] location in
            guard let self = self else { return }
            mapView.addAnnotation(location: location)
        }
    }
    
    private func setupUI() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        showCurrentLocationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
    }
    
    private func controlDbMarksAndPinThem() {
        let locations = viewModel.controlCoreDataForMarks()
        for item in locations {
            mapView.addAnnotation(location: item)
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
    
    @objc func showCurrentLocationPressed() {
        guard let location = viewModel.currentLocation else {
            return
        }
        mapView.focusTo(location: location)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            viewModel.locationUpdated(location: locations)
            DispatchQueue.once {
                mapView.focusTo(location: location)
            }
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

