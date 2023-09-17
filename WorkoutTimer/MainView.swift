//
//  ContentView.swift
//  WorkoutTimer
//
//  Created by Buba on 09.09.2023.
//

import SwiftUI

struct MainView: View {
    @State var slots = Slot.defaultSlots
    @State var rounds = 3
    @State var cycleCount = 1
    @State var settingsIsHidden = false
    @State var showFinishView = false
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            
            if showFinishView {
                FinishView(viewIsVisibly: $showFinishView)
            } else if !settingsIsHidden {
                SettingsView(
                    slots: $slots,
                    rounds: $rounds,
                    cycleCount: $cycleCount,
                    settingsIsHidden: $settingsIsHidden
                )
            } else {
                    ScrollViewReader { value in
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach($slots) { slot in
                                    TimerView(slot: slot, cycle: $cycleCount)
                                        .frame(height: UIScreen.main.bounds.height)
                                }
                            }
                        }
                        .onChange(of: cycleCount, perform: { _ in
                            withAnimation() {
                                value.scrollTo(cycleCount, anchor: .top)
                                if slots.last!.id < cycleCount {
                                    showFinishView.toggle()
                                    settingsIsHidden.toggle()
                                }
                            }
                        })
                        .ignoresSafeArea()
                        .disabled(true)
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
