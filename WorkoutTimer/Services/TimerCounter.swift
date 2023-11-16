//
//  TimerCounter.swift
//  WorkoutTimer
//
//  Created by Buba on 11.09.2023.
//

import SwiftUI
import Combine

final class TimerCounter: ObservableObject {
    static let shared = TimerCounter()
    
    @Published var secondsCount = 0
    //@Published var timerIsFinished = true
    
    private lazy var totalSeconds: Int = { secondsCount }()
    private var timer: Timer?
    
    private init() {}
    
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
        } else {
            cancelTimer()
            //timerIsFinished.toggle()
        }
    }
    
    deinit {
        print("deinit")
    }
}
