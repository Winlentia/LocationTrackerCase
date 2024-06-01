//
//  RoundedButton.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 31.05.2024.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        setTitleColor(.black, for: .normal)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
    }
    
}
