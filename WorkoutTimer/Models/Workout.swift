//
//  Workout.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

enum Option: Codable {
    case prepare
    case work
    case rest
    case finish
} 

struct Workout: Identifiable, Codable {
    var id = UUID().uuidString
    let numberOfRounds: Int
    var slots: [Slot]
}

extension Workout {
    static let defaultWorkout = Workout(numberOfRounds: 1, slots: [Slot.defaultSlot])
}

struct Slot: Identifiable, Codable {
    let id: Int
    let time: Int
    let option: Option
}

extension Slot {
    static let defaultSlot = Slot(id: 1, time: 0, option: .work)
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        let lhsWorkTime = lhs.slots.first { $0.option == .work }
        let rhsWorkTime = rhs.slots.first { $0.option == .work }
        
        let lhsRestTime = lhs.slots.first { $0.option == .rest }
        let rhsRestTime = rhs.slots.first { $0.option == .rest }
        
        if lhsWorkTime?.time == rhsWorkTime?.time
            && lhsRestTime?.time == rhsRestTime?.time
            && lhs.numberOfRounds == rhs.numberOfRounds {
            return true
        } else {
            return false
        }
    }
}
