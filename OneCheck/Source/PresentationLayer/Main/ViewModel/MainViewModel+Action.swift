//
//  MainViewModel+Action.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import CoreLocation

extension MainViewModel {
    internal enum Action {
        case viewDidLoad
        case didUpdateLocation(_ currentLocation: CLLocation)
    }
}
