//
//  DataManager.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

final class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var selectedWorkouts: [Workout] = []
    
    lazy var isWorkoutContainedInSelected: (Workout) -> Bool = { [unowned self] workout in
        selectedWorkouts.contains(workout)
    }
        
    private let userDefaults = UserDefaults()
    private let key = "selected workouts"
    
    func addWorkoutToSelected(_ workout: Workout) {
        if !isWorkoutContainedInSelected(workout) {
            selectedWorkouts.append(workout)
            setSelectedWorkoutsToUserDefaults()
        }
    }
    
    func removeWorkoutFromSelectedWorkouts(_ workout: Workout) {
        if let index = selectedWorkouts.firstIndex(where: { $0.id == workout.id }) {
            selectedWorkouts.remove(at: index)
            setSelectedWorkoutsToUserDefaults()
        }
    }
    
    func clearSelectedWorkouts() {
        selectedWorkouts = []
        setSelectedWorkoutsToUserDefaults()
    }
    
    private init() {
        getSelectedWorkoutsFromUserDefaults()
    }
    
    private func getSelectedWorkoutsFromUserDefaults() {
        guard let data = userDefaults.data(forKey: key) else { return }
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Workout].self, from: data) {
                selectedWorkouts = decodedData
        }
    }
    
    private func setSelectedWorkoutsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedWorkouts) {
            userDefaults.setValue(encoded, forKey: key)
        }
    }
}
