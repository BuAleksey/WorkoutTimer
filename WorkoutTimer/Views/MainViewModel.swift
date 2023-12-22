//
//  MainViewModel.swift
//  WorkoutTimer
//
//  Created by Buba on 20.12.2023.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    @Published var showParametrsSetupView = false
    @Published var showWorkout = false
    
    @Published var selectedWorkoutViewIsShow = false
    @Published var settingsViewIsShow = false
    @Published var isWorkoutParametrsAreValid = false
    @Published var showAddToSelectedWorkoutBtn = false
        
    @Published var numberOfRounds = 1
    @Published var workTimeMinutes = 0
    @Published var workTimeSeconds = 0
    @Published var restTimeMinutes = 0
    @Published var restTimeSeconds = 0
    
    @ObservedObject private var workoutManager = WorkoutManager.shared
    @ObservedObject private var timer = TimerCounter.shared
    
    var selectedWorkoutIsEmpty: Bool {
        DataManager.shared.selectedWorkouts.isEmpty
    }
    
    var setWorkoutFromSelected: Bool {
        workoutManager.setWorkoutFromSelected
    }
    
    private let timePresent = TimePresent.shared
    
    private var workTimeCount: Int {
        workTimeMinutes * 60 + workTimeSeconds
    }
    private var restTimeCount: Int {
        restTimeMinutes * 60 + restTimeSeconds
    }
    private var bag: [AnyCancellable] = []
    
    func makeWorkout() {
        workoutManager.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
        )
        
        checkWorkoutInSelected()
    }
    
    func startWorkout() {
        timer.clearTimer()
        if workoutManager.isWorkoutParametrsAreValid {
            withAnimation {
                showWorkout.toggle()
            }
        }
    }
    
    func addToSelectedWorkout() {
        DataManager.shared.addWorkoutToSelected(workoutManager.workout)
        withAnimation {
            showAddToSelectedWorkoutBtn = false
        }
    }
    
    func setWorkoutParametrs() {
        numberOfRounds = timePresent.setWorkoutParametrs(
            workoutManager.workout
        ).numberOfRounds
        workTimeMinutes = timePresent.setWorkoutParametrs(
            workoutManager.workout
        ).workTime.min
        workTimeSeconds = timePresent.setWorkoutParametrs(
            workoutManager.workout
        ).workTime.sec
        restTimeMinutes = timePresent.setWorkoutParametrs(
            workoutManager.workout
        ).restTime.min
        restTimeSeconds = timePresent.setWorkoutParametrs(
            workoutManager.workout
        ).restTime.sec
    }
    
    private init() {
        workoutManager.$isWorkoutParametrsAreValid
            .sink { [unowned self] bool in
                isWorkoutParametrsAreValid = bool
            }
            .store(in: &bag)
    }
    
    private func checkWorkoutInSelected() {
        showAddToSelectedWorkoutBtn = !DataManager.shared.isWorkoutContainedInSelected(workoutManager.workout)
    }
}
