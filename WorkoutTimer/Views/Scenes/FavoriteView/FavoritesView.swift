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
                                    FavoriteWorkoutCard(workout: workout)
                                }
                                .onTapGesture {
                                    self.workout = workout
                                    viewIsVisible.toggle()
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
