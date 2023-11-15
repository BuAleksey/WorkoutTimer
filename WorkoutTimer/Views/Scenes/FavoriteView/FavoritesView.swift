//
//  FavoritesView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var viewIsVisible: Bool
    @Binding var workout: Workout
    
    @ObservedObject private var dataManager = DataManager.shared
    
    @State private var showAlert = false
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                Text(
                    dataManager.favoriteWorkouts.isEmpty
                    ? "There are no favorites workouts"
                    : "FAVORITE WORKOUTS"
                )
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.bottom, 20)
                
                if dataManager.favoriteWorkouts.isEmpty {
                    Spacer()
                    Image("noFavorites")
                        .resizable()
                        .frame(width: 200, height: 200)
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: columns,
                            content: {
                                ForEach(dataManager.favoriteWorkouts) { workout in
                                    FavoriteWorkoutCard(
                                        numberOfRounds: setWorkoutParametrs(workout).numberOfRounds,
                                        workTime: setWorkoutParametrs(workout).workTime,
                                        raseTime: setWorkoutParametrs(workout).raseTime,
                                        action: { showAlert.toggle() }
                                    )
                                    .onTapGesture {
                                        self.workout = workout
                                        viewIsVisible.toggle()
                                    }
                                    .alert(
                                        "Do you want to remove the workout?",
                                        isPresented: $showAlert) {
                                            HStack {
                                                Button("OK", action: { removeWorkout(workout) })
                                                Button("Cancel", action: {})
                                            }
                                        }
                                }
                            }
                        )
                    }
                }
                Spacer()
            }
            .foregroundColor(Color("ActionColor"))
            .padding()
        }
    }
}

#Preview {
    FavoritesView(
        viewIsVisible: .constant(true),
        workout: .constant(Workout.defaultWorkout)
    )
}

//MARK: - Private metods
extension FavoritesView {
    private func setWorkoutParametrs(_ workout: Workout) -> (numberOfRounds: String, workTime: String, raseTime: String) {
        let timePresent = TimePresent.shared
        var parametrs = (numberOfRounds: "00", workTime: "00", raseTime: "00")
        
        guard let workSlot = workout.slots.first(
            where: { $0.option == .work }
        ) else { return parametrs }
        let workMin = timePresent.getMinString(sec: workSlot.time)
        let workSec = timePresent.getSecString(sec: workSlot.time)
        parametrs.workTime = "\(workMin):\(workSec)"
        
        if let raseSlot = workout.slots.first (where: { $0.option == .rest }) {
            let raseMin = timePresent.getMinString(sec: raseSlot.time)
            let raseSec = timePresent.getSecString(sec: raseSlot.time)
            parametrs.raseTime = "\(raseMin):\(raseSec)"
        } else {
            parametrs.raseTime = "00"
        }
        
        parametrs.numberOfRounds = parametrs.raseTime == "00"
        ? String(workout.slots.count)
        : String(workout.slots.count + 1)
        
        return parametrs
    }
    
    private func removeWorkout(_ workout: Workout) {
        dataManager.removeWorkoutFromFavorites(workout)
    }
}
