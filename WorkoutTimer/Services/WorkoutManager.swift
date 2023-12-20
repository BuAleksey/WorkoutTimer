//
//  WorkoutManager.swift
//  WorkoutTimer
//
//  Created by Buba on 21.09.2023.
//

import Foundation
import Combine

final class WorkoutManager: ObservableObject {
    static let shared = WorkoutManager()
    
    @Published var workout = Workout.defaultWorkout
    @Published var isWorkoutParametrsAreValid = false
    @Published var setWorkoutFromSelected = false
    
    @Published var cycleNumber = 1
    @Published var workCycleNumber = 1
    
    private init() {}
    
    func createWorkout(numberOfRounds: Int, workTimeCount: Int, restTimeCount: Int) {
        var id = 1
        var slots: [Slot] = []
        
        guard workTimeCount != 0 else {
            isWorkoutParametrsAreValid = false
            return
        }
        
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
                if restTimeCount > 0 {
                    id += 1
                    slots.append(
                        Slot(
                            id: id,
                            time: restTimeCount,
                            option: .rest
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
        
        id += 1
        let finishSlot = Slot(id: id, time: 3, option: .finish)
        slots.append(finishSlot)
        
        isWorkoutParametrsAreValid = true
        workout = Workout(numberOfRounds: numberOfRounds, slots: slots)
    }
    
    func nextCycle() {
        cycleNumber += 1
    }
    
    func nextWorkCycle() {
        workCycleNumber += 1
    }
    
    func clearCyclesCounter() {
        cycleNumber = 1
        workCycleNumber = 1
    }
}
