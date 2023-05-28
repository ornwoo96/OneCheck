//
//  DomainCircularRegion.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/27.
//

import Foundation
import CoreLocation

public class DomainCircularRegion: CLCircularRegion { }

extension DomainCircularRegion {
    static func convert(_ regions: [DomainCircle]) -> [DomainCircularRegion] {
        return regions.map { DomainCircle.convert($0) }
    }
}
