//
//  TimerViewModel.swift
//  WorkoutTimer
//
//  Created by Buba on 12.12.2023.
//

import SwiftUI
import Combine

final class TimerViewModel: ObservableObject {
    @Published var secondsCount = 0
    @Published var cycle = 1
    @Published var workCycleNumber = 0
    
    @Published var lastTenSeconds = false
    @Published var finishWorkout = false
    @Published var timerIsShow = true
    @Published var offsetTimer: CGFloat = 500
    
    @ObservedObject var timer = TimerCounter.shared
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var workoutManager = WorkoutManager.shared
    
    private let timePresent = TimePresent.shared
    private let soundManager = SoundManager.shared
    private let impact = ImpactFeedBackGenerator.shared
    private var slot = Slot.defaultSlot
    private var bag: [AnyCancellable] = []
    
    init() {
        timer.$secondsCount
            .sink { [unowned self] newValue in
                secondsCount = newValue
            }
            .store(in: &bag)
        
        timer.$cycle
            .sink { [unowned self] newValue in
                cycle = newValue
            }
            .store(in: &bag)
        
        timer.$lastTenSeconds
            .sink { [unowned self] bool in
                lastTenSeconds = bool
            }
            .store(in: &bag)
    }
    
    func setupTimer() {
        lastTenSeconds = false
        offsetViews()
        if cycle == workoutManager.workout.slots.last!.id {
            timerIsShow.toggle()
        }
        if cycle > workoutManager.workout.slots.last!.id {
            finishWorkout.toggle()
        }
        guard let nextSlot = workoutManager.workout.slots.first(where: { $0.id == cycle }) else { return }
        slot = nextSlot
        if slot.option == .work {
            workCycleNumber += 1
        }
        timer.secondsCount = slot.time
    }
    
    func setTime() -> (min: String, sec: String) {
        let min = timePresent.getMinString(sec: secondsCount)
        let sec = timePresent.getSecString(sec: secondsCount)
        return (min, sec)
    }
    
    func setupTitel() -> String {
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
    
    func setupCounterCycleTitle() -> String {
        switch slot.option {
        case .prepare:
            return ""
        case .work, .rest:
            return "\(workCycleNumber) / \(workoutManager.workout.numberOfRounds)"
        case .finish:
            return ""
        }
    }
    
    func setupImpact() {
        if dataManager.impactIsOn {
            switch slot.option {
            case .prepare, .finish:
                impact.createImpact(lavel: .light)
            case .work:
                impact.createImpact(lavel: .heavy)
            case .rest:
                impact.createImpact(lavel: .medium)
            }
        }
    }
    
    func setuplastTenSecondsSound() {
        if dataManager.audioIsOn {
            switch slot.option {
            case .prepare:
                break
            case .work, .rest:
                soundManager.play10SecSound()
            case .finish:
                break
            }
        }
    }
    
    func setupSound() {
        if dataManager.audioIsOn {
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
    
    private func offsetViews() {
        offsetTimer = 500
        withAnimation(.easeInOut(duration: 0.4)) {
            offsetTimer = .zero
        }
    }
}
