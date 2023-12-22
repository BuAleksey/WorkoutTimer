//
//  ParametrsSetupView.swift
//  WorkoutTimer
//
//  Created by Buba on 20.12.2023.
//

import SwiftUI

struct ParametrsSetupView: View {
    @ObservedObject private var viewModel = MainViewModel.shared
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Divider()
                    .frame(
                        width: UIScreen.main.bounds.width - 32,
                        height: 5
                    )
                    .padding(.bottom, 8)
                
                HStack(spacing: -3) {
                    VStack(spacing: -11) {
                        VStack(spacing: -5) {
                            Text("ROUNDS")
                            Text("NUMBER")
                        }
                        .font(.system(size: 20, weight: .thin, design: .rounded))
                        PickerView(choiceNumber: $viewModel.numberOfRounds)
                    }
                    .onChange(of: viewModel.numberOfRounds) { _ in
                        viewModel.makeWorkout()
                    }
                    
                    SelectionView(
                        timeMinutes: $viewModel.workTimeMinutes,
                        timeSeconds: $viewModel.workTimeSeconds,
                        title: "WORK"
                    )
                    .onChange(of: viewModel.workTimeMinutes) { _ in
                        viewModel.makeWorkout()
                    }
                    .onChange(of: viewModel.workTimeSeconds) { _ in
                        viewModel.makeWorkout()
                    }
                    
                    SelectionView(
                        timeMinutes: $viewModel.restTimeMinutes,
                        timeSeconds: $viewModel.restTimeSeconds,
                        title: "REST"
                    )
                    .onChange(of: viewModel.restTimeMinutes) { _ in
                        viewModel.makeWorkout()
                    }
                    .onChange(of: viewModel.restTimeSeconds) { _ in
                        viewModel.makeWorkout()
                    }
                }
                .foregroundStyle(Color.textColor)
                
                HStack {
                    HorizontalCapView(width: 100)
                    
                    Spacer()
                    
                    Button(action: viewModel.startWorkout) {
                        Text("GO")
                            .foregroundColor(.textColor)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                    }
                    
                    Spacer()
                    
                    HStack {
                        if viewModel.isWorkoutParametrsAreValid && viewModel.showAddToSelectedWorkoutBtn {
                            AddToSelectedWorkoutBtn(action: viewModel.addToSelectedWorkout)
                        } else {
                            HorizontalCapView(width: 100)
                        }
                    }
                    .offset(x: -30)
                }
            }
            .onChange(of: viewModel.setWorkoutFromSelected) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        viewModel.setWorkoutParametrs()
                    }
                }
            }
            .padding()
        }
    }
}
