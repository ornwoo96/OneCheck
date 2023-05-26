//
//  ViewController.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.bounds)

        return mapView
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupUI()
    }
    
    private func setupUI() {
        setupView()
        setupMapKitView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupMapKitView() {
        view.addSubview(self.mapView)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return print("위치 불러오기 실패") }
        let marker = Marker.createMarker(currentLocation.coordinate)
        mapView.addAnnotation(marker)
        moveToLocation(currentLocation)
    }
    
    private func moveToLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 100 // 지도의 반경 설정 (미터 단위)
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
