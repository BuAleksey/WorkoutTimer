//
//  TimerScrollModelView.swift
//  WorkoutTimer
//
//  Created by Buba on 12.12.2023.
//

import SwiftUI
import Combine

final class TimerScrollModelView: ObservableObject {
    static let shared = TimerScrollModelView()
    
    @StateObject var workoutManager = WorkoutManager.shared
    
    @Published var cycleNumber = 1
    @Published var itIsLastCycle = false
    
    lazy var numberOfRounds = workoutManager.workout.numberOfRounds
    
    private var bag: [AnyCancellable] = []
    
    private init() {
        workoutManager.$cycleNumber
            .sink { [weak self] int in
                self?.cycleNumber = int
            }
            .store(in: &bag)
    }
    
    func serchLastcycle() {
        workoutManager.$workout
            .map { [weak self] workout in
                workout.slots.last!.id == self?.cycleNumber
            }
            .sink { [weak self] bool in
                self?.itIsLastCycle = bool
            }
            .store(in: &bag)
    }
}
