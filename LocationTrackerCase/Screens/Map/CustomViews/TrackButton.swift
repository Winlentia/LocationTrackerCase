//
//  TrackButton.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import Foundation
import UIKit

final class TrackButton: RoundedButton {
    
    var isTrackingActive: Bool = true {
        didSet {
            if isTrackingActive {
                setTitle("Stop Tracking", for: .normal)
            } else {
                setTitle("Start Tracking", for: .normal)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func setupUI() {
        super.setupUI()
        setTitle("Stop Tracking", for: .normal)
    }
    
}
