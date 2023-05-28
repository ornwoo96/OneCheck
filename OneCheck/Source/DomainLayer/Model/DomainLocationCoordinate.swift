//
//  DomainLocationCoordinate.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import CoreLocation

public struct DomainLocationCoordinate {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension DomainLocationCoordinate {
    static func convert(_ coordinate: DomainLocationCoordinate) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinate.latitude,
                                      longitude: coordinate.longitude)
    }
}
