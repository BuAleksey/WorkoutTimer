//
//  TimerView.swift
//  WorkoutTimer
//
//  Created by Buba on 13.09.2023.
//

import SwiftUI

struct TimerView: View {
    @Binding var slot: Slot
    @Binding var cycle: Int
    @ObservedObject private var timer = TimerCounter()
    
    var body: some View {
        ZStack {
            if slot.option == .traning {
                Color("ActionColor")
                    .ignoresSafeArea()
            } else {
                Color("AccentColor")
                    .ignoresSafeArea()
            }
            Text(timer.secondsCount.formatted())
                .font(.system(size: 200, weight: .bold, design: .rounded))
                .shadow(color: .accentColor, radius: 3, x: 3, y: 3)
                .onAppear {
                        timer.secondsCount = slot.time
                        timer.startTimer()
                }
                .onChange(of: timer.secondsCount) { _ in
                    if timer.secondsCount == 0 {
                        cycle += 1
                    }
                }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(slot: .constant(.defaultSlot), cycle: .constant(1))
    }
}
