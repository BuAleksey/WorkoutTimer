//
//  SetupWorkoutViewModel.swift
//  WorkoutTimer
//
//  Created by Buba on 01.12.2023.
//

import SwiftUI
import Combine

final class SetupWorkoutViewModel: ObservableObject {
    static let shared = SetupWorkoutViewModel()
        
    @Published var selectedWorkoutViewIsShow = false
    @Published var settingsViewIsShow = false
    @Published var hintIsShow = false
    @Published var showAddToSelectedWorkoutBtn = false
    @Published var navigationLinkIsActive = false
        
    @Published var numberOfRounds = 1
    @Published var workTimeMinutes = 0
    @Published var workTimeSeconds = 0
    @Published var restTimeMinutes = 0
    @Published var restTimeSeconds = 0
    
    @StateObject private var workoutManager = WorkoutManager.shared
    
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
    
    func makeWorkout() {
        workoutManager.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
        )
    }
    
    func startWorkout() {
        workoutManager.clearCyclesCounter()
        if workoutManager.isWorkoutParametrsAreValid {
            navigationLinkIsActive.toggle()
        } else {
            withAnimation {
                hintIsShow = !workoutManager.isWorkoutParametrsAreValid
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation { [unowned self] in
                    self.hintIsShow = false
                }
            }
        }
    }
    
    func checkWorkoutInSelected() {
        withAnimation {
            showAddToSelectedWorkoutBtn = !DataManager.shared.isWorkoutContainedInSelected(workoutManager.workout)
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
}
