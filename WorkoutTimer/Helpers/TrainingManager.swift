//
//  TraningManager.swift
//  WorkoutTimer
//
//  Created by Buba on 21.09.2023.
//

import Foundation

final class TrainingManager {    
    func createWorkout(roundsCount: Int, trainingTimeCount: Int, resrTimeCount: Int) -> [Slot] {
        var id = 0
        var slots: [Slot] = []
        if trainingTimeCount != 0 {
            for round in 1...roundsCount {
                if round == roundsCount {
                    id += 1
                    slots.append(
                        Slot(
                            id: id,
                            time: trainingTimeCount,
                            option: .traning
                        )
                    )
                } else {
                    id += 1
                    slots.append(
                        Slot(
                            id: id,
                            time: trainingTimeCount,
                            option: .traning
                        )
                    )
                    if resrTimeCount != 0 {
                        id += 1
                        slots.append(
                            Slot(
                                id: id,
                                time: resrTimeCount,
                                option: .rase
                            )
                        )
                    }
                }
            }
        }
        return slots
    }
}
