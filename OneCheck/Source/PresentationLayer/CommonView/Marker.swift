//
//  Marker.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import MapKit

class Marker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    
    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}

extension Marker {
    static func createMarker(_ coordinate: CLLocationCoordinate2D) -> Marker {
        return Marker(title: "현재위치",
                      subtitle: "우리 집",
                      coordinate: coordinate)
    }
}
