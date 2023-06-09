//
//  LocationInCircleRegionCheckUseCaseProtocol.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation

public protocol LocationInCircleRegionCheckUseCaseProtocol {
    func circleRegionCheck(_ regions: [DomainCircularRegion],
                           _ location: DomainLocation) -> Bool 
}
