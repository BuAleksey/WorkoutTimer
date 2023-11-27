//
//  DataManager.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import Foundation

final class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var favoriteWorkouts: [Workout] = []
    
    private let userDefaults = UserDefaults()
    private let key = "favorite workouts"
    
    private init() {
        getFavoriteWorkoutsFromUserDefaults()
    }
    
    private func getFavoriteWorkoutsFromUserDefaults() {
        guard let data = userDefaults.data(forKey: key) else { return }
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Workout].self, from: data) {
                favoriteWorkouts = decodedData
        }
    }
    
    private func setFavoriteWorkoutsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteWorkouts) {
            userDefaults.setValue(encoded, forKey: key)
        }
    }
    
    func addWorkoutToFavorites(_ workout: Workout) {
        if !favoriteWorkouts.contains(workout) {
            favoriteWorkouts.append(workout)
            setFavoriteWorkoutsToUserDefaults()
        }
    }
    
    func removeWorkoutFromFavorites(_ workout: Workout) {
        if let index = favoriteWorkouts.firstIndex(where: { $0.id == workout.id }) {
            favoriteWorkouts.remove(at: index)
            setFavoriteWorkoutsToUserDefaults()
        }
    }
}
