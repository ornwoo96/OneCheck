//
//  ClickInsideCircleUseCase.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/27.
//

import Foundation
import CoreLocation

public class ClickInsideCircleUseCase: ClickInsideCircleUseCaseProtocol {
    private var circleOverlays: [DomainCircle] = []
    
    init() {}
    
    public func deleteORCreateOverlay(_ coordinate: DomainLocationCoordinate) -> (Bool, DomainOverlayProtocol) {
        if let tappedOverlay = overlay(at: coordinate) {
            circleOverlays.removeAll { $0 === tappedOverlay }
            return (true,tappedOverlay)
        } else {
            let circle = DomainCircle(center: DomainLocationCoordinate.convert(coordinate),
                                      radius: 15)
            circleOverlays.append(circle)
            return (false,circle)
        }
    }
    
    private func overlay(at coordinate: DomainLocationCoordinate) -> DomainOverlayProtocol? {
        for overlay in circleOverlays {
            if isCoordinate(coordinate, inside: overlay) {
                return overlay
            }
        }
        return nil
    }
    
    private func isCoordinate(_ coordinate: DomainLocationCoordinate,
                              inside overlay: DomainCircle) -> Bool {
        let circleCenter = overlay.coordinate
        let circleRadius = overlay.radius
        
        let location = CLLocation(latitude: circleCenter.latitude,
                                  longitude: circleCenter.longitude)
        let coordinateLocation = CLLocation(latitude: coordinate.latitude,
                                            longitude: coordinate.longitude)
        let distance = location.distance(from: coordinateLocation)
        
        return distance <= circleRadius
    }
}
