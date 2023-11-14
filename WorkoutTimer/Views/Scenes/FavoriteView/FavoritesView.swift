//
//  FavoritesView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var viewIsVisible: Bool
    @Binding var choice: Workout
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    private let dataManager = DataManager.shared
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            
            VStack {
                Text("FAVORITE WORKOUTS")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.bottom, 20)
                ScrollView {
                    LazyVGrid(columns: columns, content: {
                        ForEach(dataManager.favoriteWorkouts) { workout in
                            FavoriteWorkoutCard(
                                numberOfRounds: setWorkoutParametrs(workout).numberRounds,
                                workTime: setWorkoutParametrs(workout).workTime,
                                raseTime: setWorkoutParametrs(workout).raseTime
                            )
                            .onTapGesture {
                                print(workout.slots[2].time)
                            }
                        }
                    })
                }
                Spacer()
            }
            .foregroundColor(Color("ActionColor"))
            .padding()
        }
    }
}

#Preview {
    FavoritesView(viewIsVisible: .constant(true), choice: .constant(.defaultWorkout))
}

//MARK: - Private metods
extension FavoritesView {
    private func setWorkoutParametrs(_ workout: Workout) -> (numberRounds: String, workTime: String, raseTime: String) {
        let timePresent = TimePresent.shared
        var parametrs = (numberRounds: "00", workTime: "00", raseTime: "00")
        
        guard let workSlot = workout.slots.first(
            where: { $0.option == .traning }
        ) else { return parametrs }
        let workMin = timePresent.getMinString(sec: workSlot.time)
        let workSec = timePresent.getSecString(sec: workSlot.time)
        parametrs.workTime = "\(workMin):\(workSec)"
        
        if let raseSlot = workout.slots.first (where: { $0.option == .rase }) {
            let raseMin = timePresent.getMinString(sec: raseSlot.time)
            let raseSec = timePresent.getSecString(sec: raseSlot.time)
            parametrs.raseTime = "\(raseMin):\(raseSec)"
        } else {
            parametrs.raseTime = "00"
        }
        
        parametrs.numberRounds = parametrs.2 == "00"
        ? String(workout.slots.count)
        : String(workout.slots.count + 1)
        
        return parametrs
    }
}
