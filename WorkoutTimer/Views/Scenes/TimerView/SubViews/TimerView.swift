//
//  TimerView.swift
//  WorkoutTimer
//
//  Created by Buba on 13.09.2023.
//

import SwiftUI

struct TimerView: View {
    @Binding var slot: Slot
        
    @State private var blink = false
    @State private var blinkShadow = false
    
    var numberOfRounds = 0
    
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack {
            viewModel.setupBackgroundColor(for: slot)
                .ignoresSafeArea()
            
            VStack {
                if slot.option == .work {
                    HStack {
                        Spacer()
                        Text("\(viewModel.workCycleNumber)/\(numberOfRounds)")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .shadow(color: .accentColor, radius: 3, x: 3, y: 3)
                            .padding(.top, 30)
                    }
                }
                Text(viewModel.setupTitel(for: slot))
                    .foregroundColor(slot.option == .work ? .accentColor : .white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .opacity(blink ? 0.2 : 1)
                    .shadow(color: .accentColor, radius: 3, x: 3, y: 3)
                    .offset(y: 130)
                Spacer()
                HStack(spacing: -10) {
                    if slot.option != .finish {
                        Spacer()
                        Text(viewModel.timePresent.getMinString(sec: viewModel.secondsCount))
                        Text(":")
                        Text(viewModel.timePresent.getSecString(sec: viewModel.secondsCount))
                        Spacer()
                    }
                }
                .font(.custom("CursedTimerUlil", size: 100))
                .foregroundColor(viewModel.setupTimerColorForLastTenSeconds(for: slot))
                .shadow(
                    color: viewModel.setupShadowColorForLastTenSeconds(for: slot),
                    radius: blinkShadow ? 7 : 3, x: 3, y: 3
                )
                .onAppear {
                    viewModel.setupImpact(for: slot)
                    
                    viewModel.timer.cancelTimer()
                    viewModel.timer.secondsCount = slot.time
                    viewModel.timer.startTimer()
                    
                    viewModel.setupSound(for: slot)
                }
                .onDisappear {
                    if slot.option == .work {
                        WorkoutManager.shared.nextWorkCycle()
                    }
                }
                .onChange(of: viewModel.timer.secondsCount) { _ in
                    if slot.option != .prepare {
                        if viewModel.timer.secondsCount == 10 {
                            viewModel.soundManager.play10SecSound()
                            withAnimation(.easeIn(duration: 0.3)) {
                                blinkShadow.toggle()
                            }
                        }
                    }
                    if viewModel.timer.secondsCount == 0 {
                        WorkoutManager.shared.nextCycle()
                    }
                    if slot.option == .prepare {
                        withAnimation(.easeIn(duration: 0.3)) {
                            blink.toggle()
                        }
                    }
                    if slot.option == .rest {
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
