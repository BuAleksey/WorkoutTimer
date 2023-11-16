//
//  FavoriteWorkoutCard.swift
//  WorkoutTimer
//
//  Created by Buba on 14.11.2023.
//

import SwiftUI

struct FavoriteWorkoutCard: View {
    @State private var showAlert = false
    
    var workout: Workout
    var numberOfRounds: String {
        setWorkoutParametrs(workout).numberOfRounds
    }
    var workTime: String {
        setWorkoutParametrs(workout).workTime
    }
    var restTime: String {
        setWorkoutParametrs(workout).restTime
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.accentColor)
                .frame(width: UIScreen.main.bounds.width / 2 - 42, height: 180)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                }
            
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { showAlert.toggle() }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
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
                    .frame(width: UIScreen.main.bounds.width / 2 - 30)
                    Spacer()
                }
                .frame(height: 190)
                
                VStack {
                    Text("ROUNDS")
                        .font(.system(
                            size: 15,
                            weight: .regular,
                            design: .rounded
                        ))
                    Text("\(numberOfRounds)")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 10)
                    
                    HStack {
                        VStack {
                            Text("WORK")
                                .font(.system(
                                    size: 15,
                                    weight: .regular,
                                    design: .rounded
                                ))
                            Text("\(workTime)")
                                .font(.system(
                                    size: 15,
                                    weight: .heavy,
                                    design: .rounded
                                ))
                                .foregroundStyle(Color.white)
                        }
                        
                        VStack {
                            Text("REST")
                                .font(.system(
                                    size: 15,
                                    weight: .regular,
                                    design: .rounded
                                ))
                            Text("\(restTime)")
                                .font(.system(
                                    size: 15,
                                    weight: .heavy,
                                    design: .rounded
                                ))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .foregroundStyle(Color("ActionColor"))
            }
        }
    }
}

#Preview {
    FavoriteWorkoutCard(workout: .defaultWorkout)
}

// MARK: - Private metods
extension FavoriteWorkoutCard {
    private func setWorkoutParametrs(_ workout: Workout) -> (numberOfRounds: String, workTime: String, restTime: String) {
        let timePresent = TimePresent.shared
        var parametrs = (numberOfRounds: "00", workTime: "00", restTime: "00")
        
        guard let workSlot = workout.slots.first(
            where: { $0.option == .work }
        ) else { return parametrs }
        let workMin = timePresent.getMinString(sec: workSlot.time)
        let workSec = timePresent.getSecString(sec: workSlot.time)
        parametrs.workTime = "\(workMin):\(workSec)"
        
        if let restSlot = workout.slots.first (where: { $0.option == .rest }) {
            let restMin = timePresent.getMinString(sec: restSlot.time)
            let restSec = timePresent.getSecString(sec: restSlot.time)
            parametrs.restTime = "\(restMin):\(restSec)"
        } else {
            parametrs.restTime = "00"
        }
        
        let restSlots = workout.slots.filter({ $0.option == .rest })
        
        parametrs.numberOfRounds = parametrs.restTime == "00"
        ? String(workout.slots.count - 2)
        : String(workout.slots.count - 2 - restSlots.count)
        
        return parametrs
    }
    
    private func removeWorkout(_ workout: Workout) {
        DataManager.shared.removeWorkoutFromFavorites(workout)
    }
}
