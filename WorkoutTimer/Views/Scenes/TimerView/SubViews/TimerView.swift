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
    @Binding var workCycle: Int
    
    @State private var blink = false
    @State private var blinkShadow = false
        
    @ObservedObject private var timer = TimerCounter.shared
    @EnvironmentObject var mainSettings: MainSettings

    var numberOsRounds: Int
    
    private let timePresent = TimePresent.shared
    private let soundManager = SoundManager.shared
    private let impact = ImpactFeedBackGenerator.shared
    
    var body: some View {
        ZStack {
            setupBackgroundColor(for: slot)
                .ignoresSafeArea()
            
            VStack {
                if slot.option == .work {
                    HStack {
                        Spacer()
                        Text("\(workCycle)/\(numberOsRounds)")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .shadow(color: .accentColor, radius: 3, x: 3, y: 3)
                            .padding(.top, 30)
                    }
                }
                Text(setupTitel(for: slot))
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
                        Text(timePresent.getMinString(sec: timer.secondsCount))
                        Text(":")
                        Text(timePresent.getSecString(sec: timer.secondsCount))
                        Spacer()
                    }
                }
                .font(.custom("CursedTimerUlil", size: 100))
                .foregroundColor(setupTimerColorForLastTenSeconds(for: slot))
                .shadow(
                    color: setupShadowColorForLastTenSeconds(for: slot),
                    radius: blinkShadow ? 7 : 3, x: 3, y: 3
                )
                .onAppear {
                    setupImpact(for: slot)
                    
                    timer.cancelTimer()
                    timer.secondsCount = slot.time
                    timer.startTimer()
                    
                    setupSound(for: slot)
                }
                .onDisappear {
                    if slot.option == .work {
                        workCycle += 1
                    }
                }
                .onChange(of: timer.secondsCount) { _ in
                    if slot.option != .prepare {
                        if timer.secondsCount == 10 {
                            soundManager.play10SecSound()
                            withAnimation(.easeIn(duration: 0.3)) {
                                blinkShadow.toggle()
                            }
                        }
                    }
                    if timer.secondsCount == 0 {
                        cycle += 1
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(
            slot: .constant(.defaultSlot),
            cycle: .constant(1),
            workCycle: .constant(1),
            numberOsRounds: 5
        )
    }
}

// MARK: - Private metods
extension TimerView {
    private func setupBackgroundColor(for slot: Slot) -> Color {
        switch slot.option {
        case .prepare:
            return .prepear
        case .work:
            return .action
        case .rest:
            return .accentColor
        case .finish:
            return .finish
        }
    }
    
    private func setupTimerColorForLastTenSeconds(for slot: Slot) -> Color {
        switch slot.option {
        case .work:
            if timer.lastTenSeconds {
                return .attention
            } else {
                return .accentColor
            }
        case .rest:
            if timer.lastTenSeconds {
                return .attention
            } else {
                return .white
            }
        case .prepare, .finish:
            return .white
        }
    }
    
    private func setupShadowColorForLastTenSeconds(for slot: Slot) -> Color {
        switch slot.option {
        case .work:
            if timer.lastTenSeconds {
                return .attention
                    .opacity(0.5)
            } else {
                return .accentColor
            }
        case .rest:
            if timer.lastTenSeconds {
                return .attention
                    .opacity(0.5)
            } else {
                return .accentColor
            }
        case .prepare, .finish:
            return .accentColor
        }
    }
    
    private func setupTitel(for slot: Slot) -> String {
        switch slot.option {
        case .prepare:
            return "PREPEAR"
        case .work:
            return "WORK"
        case .rest:
            return "RELAX"
        case .finish:
            return """
                   FINISH
                   IT'S AMAZING!
                   """
        }
    }
    
    private func setupImpact(for slot: Slot) {
        if mainSettings.vibrateIsOn {
            switch slot.option {
            case .prepare:
                impact.createImpact(lavel: .light)
            case .work:
                impact.createImpact(lavel: .heavy)
            case .rest:
                impact.createImpact(lavel: .medium)
            case .finish:
                impact.createImpact(lavel: .light)
            }
        }
    }
    
    private func setupSound(for slot: Slot) {
        if mainSettings.soundIsOn {
            switch slot.option {
            case .prepare:
                break
            case .work:
                soundManager.playWorkSound()
            case .rest:
                soundManager.playRestSound()
            case .finish:
                soundManager.playRestSound()
            }
        }
    }
}
