//
//  SelectedWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct SelectedWorkoutView: View {
    @Binding var viewIsVisible: Bool
    @Binding var workout: Workout
    @Binding var selectedWorkout: Workout
    
    @ObservedObject private var dataManager = DataManager.shared
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                HStack {
                    HorizontalCapView(width: 30)
                    Spacer()
                    Text("SELECTED WORKOUTS")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Spacer()
                    ClearBntView(action: { dataManager.clearSelectedWorkouts() })
                        .frame(width: 30)
                }
                .padding(.bottom, 20)
                
                if dataManager.selectedWorkouts.isEmpty {
                    Spacer()
                    Image("clear")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(
                            columns: columns,
                            content: {
                                ForEach(dataManager.selectedWorkouts) { workout in
                                    SelectedWorkoutCard(
                                        selectedWorkout: $selectedWorkout,
                                        viewIsVisible: $viewIsVisible,
                                        workout: workout)
                                }
                            }
                        )
                    }
                }
                Spacer()
            }
            .onChange(of: dataManager.selectedWorkouts.isEmpty) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewIsVisible = false
                }
            }
            .foregroundColor(.action)
            .ignoresSafeArea()
            .padding([.top, .leading, .trailing])
        }
    }
}

#Preview {
    SelectedWorkoutView(
        viewIsVisible: .constant(true),
        workout: .constant(.defaultWorkout),
        selectedWorkout: .constant(.defaultWorkout)
    )
}
