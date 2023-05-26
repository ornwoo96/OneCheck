//
//  ViewController.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import UIKit
import MapKit
import CoreLocation
import Combine

class MainViewController: UIViewController {
    private let viewModel: MainViewModelProtocol
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.bounds)

        return mapView
    }()
    
    private let locationManager = CLLocationManager()
    private var cancellable: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.action(.viewDidLoad)
    }
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.event
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                switch $0 {
                case .none: break
                case .setupMain:
                    strongSelf.setupLocationManager()
                    strongSelf.setupUI()
                case .moveLocation(let currentLocation):
                    strongSelf.updateCurrentLocation(currentLocation)
                }
            }
            .store(in: &cancellable)
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

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return print("위치 불러오기 실패") }
        viewModel.action(.didUpdateLocation(currentLocation))
    }
    
    private func updateCurrentLocation(_ location: CLLocation) {
        drawMarker(location)
        moveMapToLocation(location)
    }
    
    private func moveMapToLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 100 // 지도의 반경 설정 (미터 단위)
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func drawMarker(_ location: CLLocation) {
        let marker = Marker.createMarker(location.coordinate)
        mapView.addAnnotation(marker)
    }
}
