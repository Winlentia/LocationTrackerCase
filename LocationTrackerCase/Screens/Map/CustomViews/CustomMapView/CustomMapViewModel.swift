//
//  CustomMapViewModel.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 2.06.2024.
//

import Foundation
import CoreLocation

struct CustomMapViewModel {
    func generateLocationTitle(placeMaker: CLPlacemark?, error: (any Error)?) -> String {
        var title = ""
        if let _ = error {
            title = "Unknown"
        } else {
            if let name = placeMaker?.name,
            let thoroughfare = placeMaker?.thoroughfare {
                title = "\(name) \n \(thoroughfare)"
            }
        }
        return title
    }
}
