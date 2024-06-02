//
//  AnnotationPopupView.swift
//  LocationTrackerCase
//
//  Created by Winlentia on 1.06.2024.
//

import Foundation
import UIKit

final class AnnotationPopupView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .green
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        layer.borderWidth = 2
        tag = 99
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
