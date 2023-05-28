//
//  MainViewModelProtocol.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import Combine

protocol MainViewModelInputProtocol {
    func action(_ action: MainViewModel.Action)
}

protocol MainViewModelOutputProtocol {
    var event: CurrentValueSubject<MainViewModel.Event, Never> { get set }
}

protocol MainViewModelProtocol: MainViewModelInputProtocol, MainViewModelOutputProtocol {
    
    
}
