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
    
    lazy var trackButton: TrackButton = {
        let button = TrackButton()
        button.addTarget(self, action: #selector(trackButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var resetPinsButton: RoundedButton = {
        let button = RoundedButton()
        button.setTitle("Reset Pins", for: .normal)
        button.addTarget(self, action: #selector(resetPinsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
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
        
        viewModel.removeAllMarkers = { [weak self] in
            guard let self = self else { return }
            mapView.removeAllAnnotations()
        }
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        showCurrentLocationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(150)
            make.height.equalTo(70)
        }
        buttonsStackView.addArrangedSubview(trackButton)
        buttonsStackView.addArrangedSubview(resetPinsButton)

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
    
    @objc func trackButtonPressed() {
        trackButton.isTrackingActive.toggle()
        viewModel.isTrackingActive = trackButton.isTrackingActive
    }
    
    @objc func resetPinsButtonPressed() {
        viewModel.resetMarkers()
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

