//
//  SelectedWorkoutCard.swift
//  WorkoutTimer
//
//  Created by Buba on 14.11.2023.
//

import SwiftUI

struct SelectedWorkoutCard: View {
    @Binding var selectedWorkout: Workout
    @Binding var viewIsVisible: Bool
    
    @State private var showAlert = false
    
    var workout: Workout
    
    private var numberOfRounds: String {
        setWorkoutParametrs(workout).numberOfRounds
    }
    private var workTime: String {
        setWorkoutParametrs(workout).workTime
    }
    private var restTime: String {
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
                            ZStack {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.attention)
                                    .font(.title2)
                            }
                        }
                        .offset(x: -7)
                        .alert(
                            "Do you want to remove the workout?",
                            isPresented: $showAlert) {
                                HStack {
                                    Button("OK", action: { removeWorkout(workout) })
                                    Button("Cancel", action: {})
                                }
                            }
                    }
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
                .foregroundStyle(Color.action)
            }
        }
        .onTapGesture {
            selectedWorkout = workout
            viewIsVisible.toggle()
        }
    }
}

#Preview {
    SelectedWorkoutCard(
        selectedWorkout: .constant(.defaultWorkout),
        viewIsVisible: .constant(true),
        workout: .defaultWorkout
    )
}

// MARK: - Private metods
extension SelectedWorkoutCard {
    private func setWorkoutParametrs(_ workout: Workout) -> (numberOfRounds: String, workTime: String, restTime: String) {
        TimePresent.shared.setWorkoutParametrsForSelectedWorkouts(workout)
    }
    
    private func removeWorkout(_ workout: Workout) {
        DataManager.shared.removeWorkoutFromSelectedWorkouts(workout)
    }
}
