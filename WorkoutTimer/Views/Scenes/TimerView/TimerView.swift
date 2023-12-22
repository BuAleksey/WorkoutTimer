//
//  TimerView.swift
//  WorkoutTimer
//
//  Created by Buba on 13.09.2023.
//

import SwiftUI

struct TimerView: View {
    @Binding var viewIsVisible: Bool
    
    @ObservedObject private var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            
                VStack {
                    HStack {
                        Spacer()
                        Text(viewModel.setupCounterCycleTitle())
                            .font(
                                .system(
                                    size: 16,
                                    weight: .ultraLight,
                                    design: .rounded
                                )
                            )
                    }
                    Spacer()
                }
                .padding()
            
            Text(viewModel.setupTitel())
                .font(.system(size: 40, weight: .thin, design: .rounded))
                .offset(y: -100)
            
            if viewModel.timerIsShow {
                HStack(spacing: -10) {
                    Spacer()
                    Text(viewModel.setTime().min)
                    Text(":")
                    Text(viewModel.setTime().sec)
                    Spacer()
                }
                .offset(y: viewModel.offsetTimer)
                .font(.custom("CursedTimerUlil", size: 100))
                .foregroundStyle(Color.inversionAccentColor)
                .shadow(color: .black, radius: 3, x: 3, y: 3)
            }
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
            viewModel.setupTimer()
        }
        .onReceive(viewModel.timer.timer) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.timer.setTimer()
            }
        }
        .onChange(of: viewModel.cycle) { _ in
            viewModel.setupTimer()
            viewModel.setupSound()
            viewModel.setupImpact()
        }
        .onChange(of: viewModel.finishWorkout) { _ in
            viewIsVisible.toggle()
        }
        .onChange(of: viewModel.lastTenSeconds) { _ in
            if viewModel.lastTenSeconds {
                viewModel.setuplastTenSecondsSound()
            }
        }
        .onTapGesture { viewIsVisible.toggle() }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
    }
}
