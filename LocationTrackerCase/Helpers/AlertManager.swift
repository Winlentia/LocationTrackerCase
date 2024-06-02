//
//  AlertManager.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 2.06.2024.
//

import Foundation
import UIKit

struct AlertManager {
    static func generateLocationPermissionAlert() -> UIAlertController {
        
        let alert = UIAlertController(title: "Location Permission", message: "This app wants to use location for tracking your activitys", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertAction.Style.default, handler:{ alert in
            if let bundleId = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } ))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        return alert
    }
    
    static func presentLocationPermissionAlert() {
        UIApplication.getTopViewController()?.present(AlertManager.generateLocationPermissionAlert(), animated: true)
    }
    
}
