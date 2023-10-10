//
//  DataManager.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    var favoriteWorkout: [Workout] = []
    
    private init() {}
    
    func addFavoriteWorkout(_ workout: Workout) {
        if !favoriteWorkout.contains(workout) {
            favoriteWorkout.append(workout)
        }
    }
    
    func removeFavoriteWorkout(_ workout: Workout) {
        if let index = favoriteWorkout.firstIndex(where: { $0.id == workout.id }) {
            favoriteWorkout.remove(at: index)
        }
    }
}
