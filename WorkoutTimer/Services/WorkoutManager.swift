//
//  WorkoutManager.swift
//  WorkoutTimer
//
//  Created by Buba on 21.09.2023.
//

import Foundation

final class WorkoutManager {
    static let shared = WorkoutManager()
    
    private init() {}
    
    func createWorkout(numberOfRounds: Int, workTimeCount: Int, raseTimeCount: Int) -> Workout? {
        var id = 1
        var slots: [Slot] = []
        guard workTimeCount != 0 else { return nil }
        let prepareSlot = Slot(id: id, time: 10, option: .prepare)
        slots.append(prepareSlot)
        for round in 1...numberOfRounds {
            if round != numberOfRounds {
                id += 1
                slots.append(
                    Slot(
                        id: id,
                        time: workTimeCount,
                        option: .work
                    )
                )
                if raseTimeCount > 0 {
                    id += 1
                    slots.append(
                        Slot(
                            id: id,
                            time: raseTimeCount,
                            option: .rase
                        )
                    )
                }
            } else {
                id += 1
                slots.append(
                    Slot(
                        id: id,
                        time: workTimeCount,
                        option: .work
                    )
                )
            }
        }
        let workout = Workout(slots: slots)
        return workout
    }
}
