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
import UserNotifications

class MainViewController: UIViewController {
    private let viewModel: MainViewModelProtocol
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self
        return mapView
    }()
    
    private let locationManager = CLLocationManager()
    private var circleOverlays: [MKCircle] = []
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
                case .removeOverlay(let overlay):
                    strongSelf.removeOverlay(overlay)
                case .createOverlay(let overlay):
                    strongSelf.drawOverlay(overlay)
                case .showNotification:
                    strongSelf.showNotification()
                }
            }
            .store(in: &cancellable)
    }
    
    private func setupUI() {
        setupView()
        setupMapKitView()
        setupTapGesture()
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
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewDidTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func mapViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        viewModel.action(.mapViewTapped(MainCoordinate.convert(coordinate)))
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return print("위치 불러오기 실패") }
        viewModel.action(.didUpdateLocation(currentLocation))
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = .red
        circleRenderer.fillColor = UIColor.yellow.withAlphaComponent(0.3)
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
}

extension MainViewController {
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
        mapView.removeAnnotations(mapView.annotations)
        let marker = Marker.createMarker(location.coordinate)
        mapView.addAnnotation(marker)
    }
    
    private func removeOverlay(_ overlay: MKOverlay) {
        mapView.removeOverlay(overlay)
    }
    
    private func drawOverlay(_ overlay: MKOverlay) {
        mapView.addOverlay(overlay)
    }
}

extension MainViewController {
    private func showNotification() {
        let alertController = UIAlertController(title: "현재 위치 알림",
                                                message: "범위에 들어와있습니다.",
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true)
    }
}
