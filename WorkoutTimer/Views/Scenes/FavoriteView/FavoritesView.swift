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
    @Binding var selectedWorkout: Workout
    
    @ObservedObject private var dataManager = DataManager.shared
    
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
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(
                            columns: columns,
                            content: {
                                ForEach(dataManager.favoriteWorkouts) { workout in
                                    FavoriteWorkoutCard(
                                        selectedWorkout: $selectedWorkout,
                                        workout: workout)
                                }
                            }
                        )
                    }
                    .onChange(of: selectedWorkout) { _ in
                        viewIsVisible.toggle()
                    }
                }
                Spacer()
            }
            .foregroundColor(Color("ActionColor"))
            .ignoresSafeArea()
            .padding([.top, .leading, .trailing])
        }
    }
}

#Preview {
    FavoritesView(
        viewIsVisible: .constant(true),
        workout: .constant(.defaultWorkout),
        selectedWorkout: .constant(.defaultWorkout)
    )
}
