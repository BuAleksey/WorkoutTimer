//
//  SelectedWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct SelectedWorkoutView: View {
    @Binding var viewIsVisible: Bool
    
    @ObservedObject private var dataManager = DataManager.shared
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                HStack {
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
                                        viewIsVisible: $viewIsVisible,
                                        workout: workout)
                                }
                            }
                        )
                    }
                }
                Spacer()
            }
            .foregroundStyle(Color.textColor)
            .onChange(of: dataManager.selectedWorkouts.isEmpty) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewIsVisible = false
                }
            }
            .ignoresSafeArea()
            .padding([.top, .leading, .trailing])
        }
    }
}
