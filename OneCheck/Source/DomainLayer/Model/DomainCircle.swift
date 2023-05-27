//
//  DomainCircle.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/27.
//

import Foundation
import MapKit

public class DomainCircle: MKCircle { }

extension DomainCircle {
    static func convert(_ circle: DomainCircle) -> DomainCircularRegion {
        return DomainCircularRegion(center: circle.coordinate,
                                    radius: circle.radius,
                                    identifier: "")
    }
}
