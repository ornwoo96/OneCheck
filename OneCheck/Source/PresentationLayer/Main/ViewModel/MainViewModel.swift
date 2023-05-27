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
        case .mapViewTapped(let coordinate):
            checkOverlayDeleteORCreate(coordinate)
        }
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
            print("범위에 들어왔습다")
            event.send(.showNotification)
        } else {
            
            print("범위 아웃")
        }
    }
}
