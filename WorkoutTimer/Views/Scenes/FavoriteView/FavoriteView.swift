//
//  FavoriteView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct FavoriteView: View {
    @Binding var viewIsVisible: Bool
    @Binding var choice: Workout
    
    private let dataManager = DataManager.shared
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                Text("FAVORITE WORKOUT")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                List(dataManager.favoriteWorkout) { workout in
                    HStack {
                        Text("Round number:")
                        Text(setWorkoutParametrs(workout).numberRounds)
                        Text("Training:")
                        Text(setWorkoutParametrs(workout).trainingTime)
                        Text("rase:")
                        Text(setWorkoutParametrs(workout).raseTime)
                    }
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        choice = workout
                    }
                }
                .listStyle(PlainListStyle())
                .background(.clear)

            }
            .foregroundColor(Color("ActionColor"))
            .padding()
        }
    }
    
    private func setWorkoutParametrs(_ workout: Workout) -> (numberRounds: String, trainingTime: String, raseTime: String) {
        var parametrs = (numberRounds: "0", trainingTime: "0", raseTime: "0")
        
        guard let trainingSlot = workout.slots.first(
            where: { $0.option == .traning }
        ) else { return parametrs }
        parametrs.trainingTime = String(trainingSlot.time)
        
        if let raseSlotIndex = workout.slots.first (where: { $0.option == .rase }) {
            parametrs.raseTime = String(raseSlotIndex.time)
        } else {
            parametrs.raseTime = "0"
        }
        
        parametrs.numberRounds = parametrs.2 == "0"
        ? String(workout.slots.count)
        : String(workout.slots.count + 1)
        
        return parametrs
    }
}

#Preview {
    FavoriteView(viewIsVisible: .constant(true), choice: .constant(.defaultWorkout))
}
