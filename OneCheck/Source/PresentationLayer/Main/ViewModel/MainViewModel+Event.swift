//
//  MainViewModel+Event.swift
//  OneCheck
//
//  Created by 김동우 on 2023/05/26.
//

import Foundation
import CoreLocation

extension MainViewModel {
    internal enum Event: Equatable {
        internal static func == (lhs: MainViewModel.Event,
                                 rhs: MainViewModel.Event) -> Bool {
            switch (lhs, rhs) {
                
            case (.none, .none):
                return true
                
            case (.setupMain, .setupMain):
                return true
                
            case (.moveLocation, .moveLocation):
                return true
                
            case (.removeOverlay, .removeOverlay):
                return true
                
            case (.createOverlay, .createOverlay):
                return true
                
            case (.showNotification, .showNotification):
                return true
                
            default:
                return false
                
            }
        }
        
        case none
        case setupMain
        case moveLocation(_ currentLocation: CLLocation)
        case removeOverlay(_ overlay: DomainOverlayProtocol)
        case createOverlay(_ overlay: DomainOverlayProtocol)
        case showNotification
    }
}
