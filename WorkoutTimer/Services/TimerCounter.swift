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
    @Published var lastTenSeconds = false
    
    private lazy var totalSeconds: Int = { secondsCount }()
    private var timer: Timer?
    private var cancellabels: [AnyCancellable] = []
    
    private init() {
        $secondsCount
            .map { numberOfSeconds in
                numberOfSeconds <= 10
            }
            .assign(to: \.lastTenSeconds, on: self)
            .store(in: &cancellabels)
    }
    
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
        }
    }
}
