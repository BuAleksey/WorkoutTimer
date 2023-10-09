//
//  ContentView.swift
//  WorkoutTimer
//
//  Created by Buba on 09.09.2023.
//

import SwiftUI

struct MainView: View {
    @State private var slots = Slot.defaultSlots
    @State private var roundsCount = 5
    @State private var cycleCount = 1
    @State private var setupIsHidden = false
    @State private var showFinishView = false
    @State private var soundIsOn = true
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            if showFinishView {
                FinishView(viewIsVisibly: $showFinishView)
                    .transition(.move(edge: .bottom))
            } else if !setupIsHidden {
                SetupWorkoutView(
                    slots: $slots,
                    roundsCount: $roundsCount,
                    setupIsHidden: $setupIsHidden,
                    soundIsOn: $soundIsOn
                )
                .transition(.move(edge: .bottom))
            } else {
                ScrollViewReader { value in
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach($slots) { slot in
                                TimerView(
                                    slot: slot,
                                    cycle: $cycleCount,
                                    setupIsHidden: $setupIsHidden,
                                    sounIsOn: $soundIsOn
                                )
                                .frame(height: UIScreen.main.bounds.height)
                            }
                        }
                    }
                    .onChange(of: cycleCount) { _ in
                        value.scrollTo(cycleCount, anchor: .top)
                        if slots.last!.id < cycleCount {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showFinishView.toggle()
                                setupIsHidden.toggle()
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .disabled(true)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            setupIsHidden.toggle()
                        }
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .onChange(of: showFinishView) { _ in
            if !showFinishView {
                UIApplication.shared.isIdleTimerDisabled = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
