//
//  ContentView.swift
//  WorkoutTimer
//
//  Created by Buba on 09.09.2023.
//

import SwiftUI

struct MainView: View {
    @State private var workout = Workout.defaultWorkout
    @State private var numberOfRounds = 5
    @State private var cycleNumber = 1
    @State private var setupWorkoutViewIsHidden = false
    @State private var showFinishView = false
    @State private var soundIsOn = true
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            if showFinishView {
                FinishView(viewIsVisibly: $showFinishView)
                    .onAppear { UIApplication.shared.isIdleTimerDisabled = false }
                    .transition(.move(edge: .bottom))
            } else if !setupWorkoutViewIsHidden {
                SetupWorkoutView(
                    workout: $workout,
                    numberOfRounds: $numberOfRounds,
                    viewIsVisible: $setupWorkoutViewIsHidden,
                    soundIsOn: $soundIsOn
                )
                .transition(.move(edge: .bottom))
            } else {
                ScrollViewReader { value in
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach($workout.slots) { slot in
                                TimerView(
                                    slot: slot,
                                    cycle: $cycleNumber,
                                    sounIsOn: soundIsOn
                                )
                                .frame(height: UIScreen.main.bounds.height)
                            }
                        }
                    }
                    .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
                    .onChange(of: cycleNumber) { _ in
                        withAnimation {
                            value.scrollTo(cycleNumber, anchor: .top)
                            if workout.slots.last!.id < cycleNumber {
                                showFinishView.toggle()
                                setupWorkoutViewIsHidden.toggle()
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .disabled(true)
                    .onTapGesture {
                        UIApplication.shared.isIdleTimerDisabled = false
                        withAnimation(.linear(duration: 0.5)) {
                            setupWorkoutViewIsHidden.toggle()
                        }
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
