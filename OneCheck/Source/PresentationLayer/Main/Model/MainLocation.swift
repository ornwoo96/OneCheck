//
//  MainLocation.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/27.
//

import Foundation
import CoreLocation

public class MainLocation: CLLocation {}

extension MainLocation {
    static func convert(_ location: CLLocation) -> MainLocation {
        return MainLocation(latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude)
    }
    
    static func convert(_ location: MainLocation) -> DomainLocation {
        return DomainLocation(latitude: location.coordinate.latitude,
                              longitude: location.coordinate.longitude)
    }
}
