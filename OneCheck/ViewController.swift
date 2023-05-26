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
    lazy var mapView: MKMapView = {
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
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("")
            print("====================================")
            print("[ locationManager() :: 위치 사용 권한 항상 허용]")
            print("====================================")
            print("")
        }
        if status == .authorizedWhenInUse {
            print("")
            print("====================================")
            print("[ locationManager() :: 위치 사용 권한 앱 사용 시 허용]")
            print("====================================")
            print("")
        }
        if status == .denied {
            print("")
            print("====================================")
            print("[ locationManager() :: 위치 사용 권한 거부]")
            print("====================================")
            print("")
        }
        if status == .restricted || status == .notDetermined {
            print("")
            print("====================================")
            print("[ locationManager() :: 위치 사용 권한 대기 상태]")
            print("====================================")
            print("")
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return print("위치 불러오기 실패") }
        
        moveToLocation(currentLocation)
    }
    
    func moveToLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000 // 지도의 반경 설정 (미터 단위)
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
