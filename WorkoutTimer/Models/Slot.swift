//
//  Slot.swift
//  WorkoutTimer
//
//  Created by Buba on 11.09.2023.
//

import Foundation

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
    case traning
    case rase
}
