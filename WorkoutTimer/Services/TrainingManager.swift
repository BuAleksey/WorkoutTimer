//
//  TraningManager.swift
//  WorkoutTimer
//
//  Created by Buba on 21.09.2023.
//

import Foundation

final class TrainingManager {
    func createWorkout(roundsCount: Int, trainingTimeCount: Int, resrTimeCount: Int) -> Workout? {
        var id = 0
        var slots: [Slot] = []
        guard trainingTimeCount != 0 else { return nil }
        for round in 1...roundsCount {
            if round != roundsCount {
                id += 1
                slots.append(
                    Slot(
                        id: id,
                        time: trainingTimeCount,
                        option: .traning
                    )
                )
                if resrTimeCount > 0 {
                    id += 1
                    slots.append(
                        Slot(
                            id: id,
                            time: resrTimeCount,
                            option: .rase
                        )
                    )
                }
            } else {
                id += 1
                slots.append(
                    Slot(
                        id: id,
                        time: trainingTimeCount,
                        option: .traning
                    )
                )
            }
        }
        let workout = Workout(slots: slots)
        return workout
    }
}
