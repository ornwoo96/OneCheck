//
//  MainViewModel.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import Combine

class MainViewModel: MainViewModelProtocol {
    private let regionCheckUseCase: LocationInCircleRegionCheckUseCaseProtocol
    private let clickInsideCircleUseCase: ClickInsideCircleUseCaseProtocol
    private var currentLocation: MainLocation = MainLocation()
    private var isFirstNotification: Bool = true
    private var isBackground: Bool = false
    var event: CurrentValueSubject<Event, Never> = .init(.none)
    
    init(regionCheckUseCase: LocationInCircleRegionCheckUseCaseProtocol,
         clickInsideCircleUseCase: ClickInsideCircleUseCaseProtocol) {
        self.regionCheckUseCase = regionCheckUseCase
        self.clickInsideCircleUseCase = clickInsideCircleUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewDidLoad:
            event.send(.setupMain)
        case .didUpdateLocation(let currentLocation):
            event.send(.moveLocation(currentLocation))
            checkRegion(MainLocation.convert(currentLocation))
            self.currentLocation = MainLocation.convert(currentLocation)
        case .mapViewTapped(let coordinate):
            checkOverlayDeleteORCreate(coordinate)
            checkRegion(self.currentLocation)
        }
    }
    
    func setupIsBackgroundForTrue() {
        isBackground = true
    }
    
    func setupIsBackgroundForFalse() {
        isBackground = false
    }
    
    private func checkOverlayDeleteORCreate(_ coordinate: MainCoordinate) {
        let overlay = clickInsideCircleUseCase.deleteORCreateOverlay(MainCoordinate.convert(coordinate))
        if overlay.0 {
            event.send(.removeOverlay(overlay.1))
        } else {
            event.send(.createOverlay(overlay.1))
        }
    }
    
    private func checkRegion(_ location: MainLocation) {
        let regions = clickInsideCircleUseCase.getOverlayCLCircularRegions()
        if regionCheckUseCase.circleRegionCheck(DomainCircularRegion.convert(regions),
                                                MainLocation.convert(location)) {
            checkIsFirstNotification()
        } else {
            isFirstNotification = true
        }
    }
    
    private func checkIsFirstNotification() {
//        if isFirstNotification {
            checkIsBackground()
            event.send(.showNotification)
            isFirstNotification = false
//        }
    }
    
    private func checkIsBackground() {
        if isBackground {
            event.send(.pushNotification)
        }
    }
}
