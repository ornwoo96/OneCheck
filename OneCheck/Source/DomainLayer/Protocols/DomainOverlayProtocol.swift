//
//  DomainModel.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import MapKit

public protocol DomainOverlayProtocol: MKOverlay {}

extension MKCircle: DomainOverlayProtocol {}
