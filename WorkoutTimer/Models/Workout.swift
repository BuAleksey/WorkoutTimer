//
//  Workout.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

struct Workout: Identifiable, Codable {
    var id = UUID()
    var slots: [Slot]
    
    static let defaultWorkout = Workout(slots: [Slot.defaultSlot])
}

struct Slot: Identifiable, Codable {
    let id: Int
    let time: Int
    let option: Option
    
    static let defaultSlot = Slot(id: 0, time: 5, option: .work)
}

enum Option: Codable {
    case prepare
    case work
    case rest
    case finish
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        let lhsTrainingTime = lhs.slots.first { $0.option == .work }
        let rhsTrainingTime = rhs.slots.first { $0.option == .work }
        
        let lhsRestTime = lhs.slots.first { $0.option == .rest }
        let rhsRestTime = rhs.slots.first { $0.option == .rest }
        
        if lhsTrainingTime?.time == rhsTrainingTime?.time && lhsRestTime?.time == rhsRestTime?.time {
            return true
        } else {
            return false
        }
    }
}
