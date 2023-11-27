//
//  ImpactFeedBackGenerator.swift
//  WorkoutTimer
//
//  Created by Buba on 23.11.2023.
//

import UIKit

enum ImpactLavel {
    case light
    case medium
    case heavy
}

class ImpactFeedBackGenerator {
    static let shared = ImpactFeedBackGenerator()
    
    private init() {}
    
    func createImpact(lavel: ImpactLavel) {
        var impact = UIImpactFeedbackGenerator()
        
        switch lavel {
        case .light:
            impact = UIImpactFeedbackGenerator(style: .light)
        case .medium:
            impact = UIImpactFeedbackGenerator(style: .medium)
        case .heavy:
            impact = UIImpactFeedbackGenerator(style: .heavy)
        }
        
        impact.prepare()
        impact.impactOccurred()
    }
}
