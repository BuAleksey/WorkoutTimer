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
    
    @ObservedObject private var timer = TimerCounter.shared
    
    var sounIsOn: Bool
    var numberOsRounds: Int
    
    private let timePresent = TimePresent.shared
    private let sounManager = SoundManager()
    
    var body: some View {
        ZStack {
            setupBackgroundColor(for: slot.option)
                .ignoresSafeArea()
            
            VStack {
                if slot.option == .work {
                    HStack {
                        Spacer()
                        Text("\(workCycle)/\(numberOsRounds)")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.top, 40)
                    }
                }
                Text(setupTitel(for: slot.option))
                    .foregroundColor(slot.option == .work ? .accentColor : .white)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
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
                .foregroundColor(slot.option == .work ? .accentColor : .white)
                .shadow(color: .accentColor, radius: 3, x: 3, y: 3)
                .onAppear {
                    timer.cancelTimer()
                    timer.secondsCount = slot.time
                    timer.startTimer()
                    if sounIsOn, slot.option == .work {
                        sounManager.playWorkSound()
                    }
                }
                .onDisappear {
                    if slot.option == .work {
                        workCycle += 1
                    }
                }
                .onChange(of: timer.secondsCount) { _ in
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
            sounIsOn: true,
            numberOsRounds: 5
        )
    }
}

// MARK: - Private metods
extension TimerView {
    private func setupBackgroundColor(for slot: Option) -> Color {
        switch slot {
        case .prepare:
            return Color("PrepearColor")
        case .work:
            return Color("ActionColor")
        case .rest:
            return Color("AccentColor")
        case .finish:
            return Color("FinishColor")
            
        }
    }
    
    private func setupTitel(for slot: Option) -> String {
        switch slot {
        case .prepare:
            return "PREPEAR"
        case .work:
            return ""
        case .rest:
            return "RELAX"
        case .finish:
            return """
                   FINISH
                   IT'S AMAZING!
                   """
        }
    }
}
