//
//  TimePresent.swift
//  WorkoutTimer
//
//  Created by Buba on 20.09.2023.
//

import Foundation

final class TimePresent {
    static let shared = TimePresent()
    
    private init() {}
    
    func getMinString(sec: Int) -> String {
        let min = sec / 60
        if min < 10 {
            return "0" + String(min)
        } else {
            return String(min)
        }
    }
    
    func getSecString(sec: Int) -> String {
        let remainderOfSec = sec % 60
        if remainderOfSec < 10 {
            return "0" + String(remainderOfSec)
        } else {
            return String(remainderOfSec)
        }
    }
    
    func setWorkoutParametrsForSelectedWorkouts(_ workout: Workout) -> (numberOfRounds: String, workTime: String, restTime: String) {
        var parametrs = (numberOfRounds: "-", workTime: "-", restTime: "-")
        
        guard let workSlot = workout.slots.first(
            where: { $0.option == .work }
        ) else { return parametrs }
        let workMin = getMinString(sec: workSlot.time)
        let workSec = getSecString(sec: workSlot.time)
        parametrs.workTime = "\(workMin):\(workSec)"
        
        parametrs.numberOfRounds = String(workout.numberOfRounds)
        
        if let restSlot = workout.slots.first (where: { $0.option == .rest }) {
            let restMin = getMinString(sec: restSlot.time)
            let restSec = getSecString(sec: restSlot.time)
            parametrs.restTime = "\(restMin):\(restSec)"
        }
                
        return parametrs
    }
    
    func setWorkoutParametrs(_ workout: Workout) -> (numberOfRounds: Int, workTime: (min: Int, sec: Int), restTime: (min: Int, sec: Int)) {
        var parametrs = (
            numberOfRounds: 1, 
            workTime: (min: 0, sec: 0),
            restTime: (min: 0, sec: 0)
        )
        
        guard let workSlot = workout.slots.first(where: { $0.option == .work })
        else { return parametrs }
        
        let workMin = workSlot.time / 60
        let workSec = workSlot.time % 60
        
        parametrs.workTime.min = workMin
        parametrs.workTime.sec = workSec
        
        parametrs.numberOfRounds = workout.numberOfRounds
        
        if let restSlot = workout.slots.first (where: { $0.option == .rest }) {
            let restMin = restSlot.time / 60
            let restSec = restSlot.time % 60
            parametrs.restTime.min = restMin
            parametrs.restTime.sec = restSec
        }
        
        return parametrs
    }
}
