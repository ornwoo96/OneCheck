//
//  MainModel.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import MapKit

protocol MainOverlay: MKOverlay { }

struct MainCoordinate {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double,
         longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension MainCoordinate {
    static func convert(_ coordinate: CLLocationCoordinate2D) -> MainCoordinate {
        return MainCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    static func convert(_ coordinate: MainCoordinate) -> DomainLocationCoordinate {
        return DomainLocationCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

