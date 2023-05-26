//
//  ViewController.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.bounds)

        return mapView
    }()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        return locationManager
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

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return print("위치 불러오기 실패") }
        
        
    }
}
