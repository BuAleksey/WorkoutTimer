//
//  TimePresent.swift
//  WorkoutTimer
//
//  Created by Buba on 20.09.2023.
//

import Foundation

final class TimePresent {
    func getTimeString(sec: Int) -> String {
        let min = sec / 60
        let remainderOfSec = sec % 60
        if remainderOfSec < 10 {
            return String(min) + ":" + "0" + String(remainderOfSec)
        } else {
            return String(min) + ":" + String(remainderOfSec)
        }
    }
    
    func getMinString(sec: Int) -> String {
        let min = sec / 60
        return String(min)
    }
    
    func getSecString(sec: Int) -> String {
        let remainderOfSec = sec % 60
        if remainderOfSec < 10 {
            return "0" + String(remainderOfSec)
        } else {
            return String(remainderOfSec)
        }
    }
}
