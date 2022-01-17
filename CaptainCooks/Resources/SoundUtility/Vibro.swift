//
//  Vibro.swift
//  CaptainCooks
//
//  Created by Harry Crocks on 1/14/22.
//

import UIKit

enum Vibro {
    
    case error
    case success
    case light
    case medium
    case selection

    public func vibrate() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
            
        }
    }
}
