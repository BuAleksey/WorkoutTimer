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
    @Binding var settingsIsHidden: Bool
    
    @State private var shake = false
    @State private var blink = false
    
    @ObservedObject private var timer = TimerCounter()
    private let timePresent = TimePresent()
    
    var body: some View {
        ZStack {
            Color(slot.option == .traning ? "ActionColor" : "AccentColor")
                .ignoresSafeArea()
            VStack {
                Text(slot.option == .traning ? "MOVE" : "RELAX")
                    .foregroundColor(slot.option == .traning ? .accentColor : .white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .rotationEffect(.degrees(shake ? 5 : 0))
                    .animation(
                        .interpolatingSpring(
                            mass: 1,
                            stiffness: 5,
                            damping: 0,
                            initialVelocity: 1
                        ),
                        value: shake
                    )
                    .opacity(blink ? 0.2 : 1)
                    .shadow(color: .accentColor, radius: 3, x: 3, y: 3)
                    .offset(y: 130)
                Spacer()
                HStack(spacing: -10) {
                    Spacer()
                    Text(timePresent.getMinString(sec: timer.secondsCount))
                    Text(":")
                    Text(timePresent.getSecString(sec: timer.secondsCount))
                    Spacer()
                }
                .font(.custom("CursedTimerUlil", size: 100))
                .foregroundColor(slot.option == .traning ? .accentColor : .white)
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
                .onChange(of: timer.secondsCount) { _ in
                    if slot.option == .traning {
                        shake.toggle()
                    } else {
                        withAnimation(.easeIn(duration: 1)) {
                            blink.toggle()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(slot: .constant(.defaultSlot), cycle: .constant(1), settingsIsHidden: .constant(true))
    }
}
