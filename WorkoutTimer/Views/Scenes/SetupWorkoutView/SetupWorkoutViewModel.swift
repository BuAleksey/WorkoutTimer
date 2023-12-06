//
//  SetupWorkoutViewModel.swift
//  WorkoutTimer
//
//  Created by Buba on 01.12.2023.
//

import SwiftUI
import Combine

final class SetupWorkoutViewModel: ObservableObject {
    @Published var workout = Workout.defaultWorkout
    
    @Published var selectedWorkoutViewIsShow = false
    @Published var settingsIsShow = false
    
    @Published var hintIsShow = false
    @Published var showAddToSelectedWorkoutBtn = false
    @Published var navigationLinkIsActive = false
    
    @Published var selectedWorkout = Workout.defaultWorkout
    
    @Published var numberOfRounds = 1
    
    var selectedWorkoutIsEmpty: Bool {
        DataManager.shared.selectedWorkouts.isEmpty
    }
    
    private let timePresent = TimePresent.shared
    
    @Published var workTimeMinutes = 0
    @Published var workTimeSeconds = 0
    @Published var restTimeMinutes = 0
    @Published var restTimeSeconds = 0
    
    private var workTimeCount: Int {
        workTimeMinutes * 60 + workTimeSeconds
    }
    private var restTimeCount: Int {
        restTimeMinutes * 60 + restTimeSeconds
    }
    
    //private var cancellabels: [AnyCancellable] = []
    
    private var isWorkoutParametrsAreValid: AnyPublisher<Bool,Never> {
        $workTimeMinutes
            .debounce(for: 3, scheduler: RunLoop.main)
            .map { input in
                input == 0
            }
            .eraseToAnyPublisher()
    }
    
    init() {
//        $workTimeMinutes
//            .debounce(for: 3, scheduler: RunLoop.main)
//            .removeDuplicates()
//            .map { input in
//                input == 0
//            }
//            .assign(to: \.hintIsShow, on: self)
//            .store(in: &cancellabels)
    }
    
    func startWorkout() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
        ) else {
            withAnimation {
                hintIsShow = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation { [unowned self] in
                    self.hintIsShow = false
                }
            }
            return
        }
        self.workout = workout
        navigationLinkIsActive.toggle()
    }
    
    func checkWorkoutInSelected() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
        ) else { return }
        withAnimation {
            showAddToSelectedWorkoutBtn = !DataManager.shared.isWorkoutContainedInSelected(workout)
        }
    }
    
    func addToSelectedWorkout() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
        ) else { return }
        DataManager.shared.addWorkoutToSelected(workout)
        showAddToSelectedWorkoutBtn = false
    }
    
    func setWorkoutParametrs() {
        numberOfRounds = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).numberOfRounds
        workTimeMinutes = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).workTime.min
        workTimeSeconds = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).workTime.sec
        restTimeMinutes = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).restTime.min
        restTimeSeconds = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).restTime.sec
    }
}
