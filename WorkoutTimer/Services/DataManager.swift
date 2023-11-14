//
//  DataManager.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    var favoriteWorkouts: [Workout] = []
    
    private init() {}
    
    func addWorkoutToFavorites(_ workout: Workout) {
        if !favoriteWorkouts.contains(workout) {
            favoriteWorkouts.append(workout)
        }
    }
    
    func removeWorkoutFromFavorites(_ workout: Workout) {
        if let index = favoriteWorkouts.firstIndex(where: { $0.id == workout.id }) {
            favoriteWorkouts.remove(at: index)
        }
    }
}
