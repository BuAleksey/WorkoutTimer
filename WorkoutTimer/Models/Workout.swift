//
//  Workout.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    var slots: [Slot]
    
    static let defaultWorkout = Workout(slots: [Slot.defaultSlot])
}

struct Slot: Identifiable {
    let id: Int
    let time: Int
    let option: Option
    
    static let defaultSlot = Slot(id: 0, time: 5, option: .traning)
    static let defaultSlots = [
        Slot(id: 0, time: 5, option: .traning),
        Slot(id: 1, time: 3, option: .rase),
        Slot(id: 2, time: 5, option: .traning),
        Slot(id: 3, time: 3, option: .rase),
        Slot(id: 4, time: 5, option: .traning)
    ]
}

enum Option {
    case prepare
    case traning
    case rase
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        let lhsTrainingTime = lhs.slots.first { $0.option == .traning }
        let rhsTrainingTime = rhs.slots.first { $0.option == .traning }
        
        let lhsRaseTime = lhs.slots.first { $0.option == .rase }
        let rhsRaseTime = rhs.slots.first { $0.option == .rase }
        
        if lhsTrainingTime?.time == rhsTrainingTime?.time && lhsRaseTime?.time == rhsRaseTime?.time {
            return true
        } else {
            return false
        }
    }
}
