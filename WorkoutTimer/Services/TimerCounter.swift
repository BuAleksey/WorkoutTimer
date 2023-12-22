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
    @Published var cycle = 1
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var bag: [AnyCancellable] = []
    
    private init() {
        $secondsCount
            .map { numberOfSeconds in
                numberOfSeconds == 10
            }
            .assign(to: \.lastTenSeconds, on: self)
            .store(in: &bag)
    }
    
    func setTimer() {
        if secondsCount > 0 {
            secondsCount -= 1
        } else {
            cycle += 1
        }
    }
    
    func clearTimer() {
        secondsCount = 1
        cycle = 1
        lastTenSeconds = false
    }
}
