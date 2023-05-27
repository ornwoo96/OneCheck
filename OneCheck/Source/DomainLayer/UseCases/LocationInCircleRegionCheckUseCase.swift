//
//  LocationInCircleRegionCheckUseCase.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import CoreLocation

class LocationInCircleRegionCheckUseCase: LocationInCircleRegionCheckUseCaseProtocol {
    
    init() {}
    
    public func circleRegionCheck(_ regions: [DomainCircularRegion],
                                  _ location: DomainLocation) -> Bool {
        for region in regions {
            if region.contains(location.coordinate) {
                return true
            }
        }
        
        return false
    }
}
