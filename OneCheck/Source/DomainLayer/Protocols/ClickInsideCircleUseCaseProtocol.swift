//
//  ClickInsideCircleUseCaseProtocol.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/27.
//

import Foundation

public protocol ClickInsideCircleUseCaseProtocol {
    func deleteORCreateOverlay(_ coordinate: DomainLocationCoordinate) -> (Bool, DomainOverlayProtocol)
    func getOverlayCLCircularRegions() -> [DomainCircle]
}
