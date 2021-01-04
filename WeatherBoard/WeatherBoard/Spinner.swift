//
//  Spinner.swift
//  WeatherBoard
//
//  Created by Baris Berkin Tasci on 3.01.2021.
//

import Foundation
import NVActivityIndicatorView

class Spinner {
    static func start() {
        let mySpinner = NVActivityIndicatorView(frame: CGRect.init(x: 100.0, y: 100.0, width: 200.0, height: 200.0), type: .ballTrianglePath, color: .systemTeal, padding: 0)
        
        mySpinner.startAnimating()
    }
    
    static func stop() {
        let mySpinner = NVActivityIndicatorView(frame: .zero, type: .ballTrianglePath, color: .systemTeal, padding: 0)
        mySpinner.stopAnimating()
    }
}
