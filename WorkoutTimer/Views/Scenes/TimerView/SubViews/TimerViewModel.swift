//
//  TimerViewModel.swift
//  WorkoutTimer
//
//  Created by Buba on 12.12.2023.
//

import SwiftUI
import Combine

final class TimerViewModel: ObservableObject {
    @State private var blink = false
    @State private var blinkShadow = false
    
    @Published var secondsCount = 0
    @Published var workCycleNumber = 1
        
    @StateObject var timer = TimerCounter.shared
    @StateObject private var mainSettings = MainSettings.shared
    
    let timePresent = TimePresent.shared
    let soundManager = SoundManager.shared
    let impact = ImpactFeedBackGenerator.shared
    
    @StateObject private var workoutManager = WorkoutManager.shared
    
    private var bag: [AnyCancellable] = []
    
    init() {
        timer.$secondsCount
            .sink { seconds in
                self.secondsCount = seconds
            }
            .store(in: &bag)
        
        workoutManager.$workCycleNumber
            .sink { cycle in
                self.workCycleNumber = cycle
            }
            .store(in: &bag)
    }
    
    func setupBackgroundColor(for slot: Slot) -> Color {
        switch slot.option {
        case .prepare:
            return .prepear
        case .work:
            return .action
        case .rest:
            return .accentColor
        case .finish:
            return .finish
        }
    }
    
    func setupTimerColorForLastTenSeconds(for slot: Slot) -> Color {
        switch slot.option {
        case .work:
            if timer.lastTenSeconds {
                return .attention
            } else {
                return .accentColor
            }
        case .rest:
            if timer.lastTenSeconds {
                return .attention
            } else {
                return .white
            }
        case .prepare, .finish:
            return .white
        }
    }
    
    func setupShadowColorForLastTenSeconds(for slot: Slot) -> Color {
        switch slot.option {
        case .work:
            if timer.lastTenSeconds {
                return .attention
                    .opacity(0.5)
            } else {
                return .accentColor
            }
        case .rest:
            if timer.lastTenSeconds {
                return .attention
                    .opacity(0.5)
            } else {
                return .accentColor
            }
        case .prepare, .finish:
            return .accentColor
        }
    }
    
    func setupTitel(for slot: Slot) -> String {
        switch slot.option {
        case .prepare:
            return "PREPEAR"
        case .work:
            return "WORK"
        case .rest:
            return "RELAX"
        case .finish:
            return """
                   FINISH
                   IT'S AMAZING!
                   """
        }
    }
    
    func setupImpact(for slot: Slot) {
        if mainSettings.vibrateIsOn {
            switch slot.option {
            case .prepare:
                impact.createImpact(lavel: .light)
            case .work:
                impact.createImpact(lavel: .heavy)
            case .rest:
                impact.createImpact(lavel: .medium)
            case .finish:
                impact.createImpact(lavel: .light)
            }
        }
    }
    
    func setupSound(for slot: Slot) {
        if mainSettings.soundIsOn {
            switch slot.option {
            case .prepare:
                break
            case .work:
                soundManager.playWorkSound()
            case .rest:
                soundManager.playRestSound()
            case .finish:
                soundManager.playRestSound()
            }
        }
    }
}
