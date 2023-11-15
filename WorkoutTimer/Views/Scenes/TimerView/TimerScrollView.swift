//
//  TimerScrollView.swift
//  WorkoutTimer
//
//  Created by Buba on 15.11.2023.
//

import SwiftUI

struct TimerScrollView: View {
    @Binding var workout: Workout
    @Binding var soundIsOn: Bool
    @Binding var navigationLinkIsActive: Bool
    
    @State private var cycleNumber = 1
    
    var numberOsRounds: Int
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach($workout.slots) { slot in
                        TimerView(
                            slot: slot,
                            cycle: $cycleNumber,
                            sounIsOn: soundIsOn,
                            numberOsRounds: numberOsRounds
                        )
                        .frame(height: UIScreen.main.bounds.height)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
            .onChange(of: cycleNumber) { _ in
                withAnimation {
                    value.scrollTo(cycleNumber, anchor: .top)
                }
                if workout.slots.last!.id < cycleNumber {
                    navigationLinkIsActive.toggle()
                    TimerCounter.shared.cancelTimer()
                }
            }
            .ignoresSafeArea()
            .disabled(true)
            .onTapGesture {
                UIApplication.shared.isIdleTimerDisabled = false
                navigationLinkIsActive.toggle()
                TimerCounter.shared.cancelTimer()
            }
        }
        .transition(.move(edge: .bottom))
    }
}

#Preview {
    TimerScrollView(
        workout: .constant(Workout.defaultWorkout),
        soundIsOn: .constant(true),
        navigationLinkIsActive: .constant(true),
        numberOsRounds: 5
    )
}
