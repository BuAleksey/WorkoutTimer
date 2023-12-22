//
//  MainView.swift
//  WorkoutTimer
//
//  Created by Buba on 15.11.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = MainViewModel.shared
    
    var body: some View {
        ZStack {
            StartTimerView()
            
            if viewModel.showParametrsSetupView {
                HeadView()
                
                ParametrsSetupView()
                    .transition(.move(edge: .bottom))
            }
            
            if viewModel.showWorkout {
                TimerView(viewIsVisible: $viewModel.showWorkout)
                    .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1)) {
                    viewModel.showParametrsSetupView.toggle()
                }
            }
        }
    }
}
