//
//  ViewController.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.bounds)

        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupMapKitView()
    }
    
    private func setupMapKitView() {
        view.addSubview(self.mapView)
    }
}
