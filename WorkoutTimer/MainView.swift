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
    @State var trainingTime = 5
    @State var restTime = 3
    
    @State var cycleCount = 1
    @State var startTimer = false
    
    @State private var selectionIsHidden = false
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            
            if !selectionIsHidden {
                VStack {
                    HStack {
                        Text("ROUNDS:")
                        Spacer()
                        SelectionView(choiceNumber: $rounds)
                    }
                    HStack {
                        Text("Time of training:")
                        Spacer()
                        SelectionView(choiceNumber: $trainingTime)
                    }
                    HStack {
                        Text("Time of rest:")
                        Spacer()
                        SelectionView(choiceNumber: $restTime)
                    }
                    Button(action: startTraining) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 300, height: 60)
                            Text("GO")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(16)
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
                            }
                        })
                        .ignoresSafeArea()
                        .disabled(true)
                    }
                }
        }
    }
    
    private func startTraining() {
        createWorkout()
        withAnimation {
            selectionIsHidden.toggle()
        }
    }
    
    private func createWorkout() {
        slots.removeAll()
        var id = 0
        for round in 1...rounds {
            if round == rounds {
                id += 1
                slots.append(Slot(id: id, time: trainingTime, option: .traning))
            } else {
                id += 1
                slots.append(Slot(id: id, time: trainingTime, option: .traning))
                id += 1
                slots.append(Slot(id: id, time: restTime, option: .rase))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
