//
//  TimerScrollView.swift
//  WorkoutTimer
//
//  Created by Buba on 15.11.2023.
//

import SwiftUI

struct TimerScrollView: View {
    @Binding var navigationLinkIsActive: Bool
    @StateObject private var viewModel = TimerScrollModelView.shared
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach($viewModel.workoutManager.workout.slots) { slot in
                        TimerView(
                            slot: slot,
                            numberOfRounds: viewModel.numberOfRounds
                        )
                        .frame(height: UIScreen.main.bounds.height)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
            .onChange(of: viewModel.cycleNumber) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        value.scrollTo(viewModel.cycleNumber, anchor: .top)
                    }
                }
                viewModel.serchLastcycle()
                if viewModel.itIsLastCycle {
                    navigationLinkIsActive.toggle()
                }
            }
            .ignoresSafeArea()
            .disabled(true)
            .onTapGesture {
                UIApplication.shared.isIdleTimerDisabled = false
                navigationLinkIsActive.toggle()
            }
        }
        .transition(.move(edge: .bottom))
    }
}
