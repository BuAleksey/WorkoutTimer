//
//  TimerCounter.swift
//  WorkoutTimer
//
//  Created by Buba on 11.09.2023.
//

import SwiftUI
import Combine

final class TimerCounter: ObservableObject {
    @Published var secondsCount = 0
    @Published var timerIsFinished = true
    @Published var lastThreeSeconds = false
    
    private lazy var totalSeconds: Int = { secondsCount }()
    
    private var timer: Timer?
    
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        if secondsCount > 0 {
            secondsCount -= 1
            if secondsCount < 3 {
                lastThreeSeconds.toggle()
            }
        } else {
            timer?.invalidate()
            timer = nil
            timerIsFinished.toggle()
        }
    }
}
