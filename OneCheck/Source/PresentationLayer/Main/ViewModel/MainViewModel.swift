//
//  MainViewModel.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import Combine

class MainViewModel: MainViewModelProtocol {
    let useCase: LocationInCircleRegionCheckUseCaseProtocol
    var event: CurrentValueSubject<Event, Never> = .init(.none)
    
    init(useCase: LocationInCircleRegionCheckUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewDidLoad:
            event.send(.setupMain)
        case .didUpdateLocation(let currentLocation):
            event.send(.moveLocation(currentLocation))
        }
    }
}
