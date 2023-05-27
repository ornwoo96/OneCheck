//
//  DIContainer.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation

class MainDIContainer {
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeMainViewModel())
    }
    
    private func makeMainViewModel() -> MainViewModelProtocol {
        return MainViewModel(regionCheckUseCase: makeLocationInCircleRegionCheckUseCase(),
                             clickInsideCircleUseCase: makeClickInsideCircleUseCase())
    }
    
    private func makeLocationInCircleRegionCheckUseCase() -> LocationInCircleRegionCheckUseCaseProtocol {
        return LocationInCircleRegionCheckUseCase()
    }
    
    private func makeClickInsideCircleUseCase() -> ClickInsideCircleUseCaseProtocol {
        return ClickInsideCircleUseCase()
    }
}
