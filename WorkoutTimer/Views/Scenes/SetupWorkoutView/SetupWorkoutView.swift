//
//  SetupWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct SetupWorkoutView: View {
    @Binding var slots: [Slot]
    @Binding var roundsCount: Int
    @Binding var setupIsHidden: Bool
    @Binding var soundIsOn: Bool
    
    @State private var traningTimeInMinutes = 0
    @State private var traningTimeInSeconds = 0
    
    @State private var restTimeInMinutes = 0
    @State private var restTimeInSeconds = 0
    
    @State private var hintIsShow = false
    @State private var settingsIsShow = false
    
    private var trainingTimeCount: Int {
        traningTimeInMinutes * 60 + traningTimeInSeconds
    }
    private var resrTimeCount: Int {
        restTimeInMinutes * 60 + restTimeInSeconds
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .font(.title)
                    .foregroundColor(Color("ActionColor"))
                    .onTapGesture {
                        settingsIsShow.toggle()
                    }
                    .sheet(isPresented: $settingsIsShow, content: {
                        SettingsView(
                            viewIsVisible: $settingsIsShow,
                            soundIsOn: $soundIsOn
                        )
                    })
            }
            Spacer()
            Text("LET'S START TAINING")
                .foregroundColor(Color("ActionColor"))
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Spacer()
            HStack {
                VStack(spacing: -1) {
                    Text("ROUNDS")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    SelectionView(choiceNumber: $roundsCount)
                }
                .foregroundColor(Color("ActionColor"))
                VStack {
                    Text("TRAINING")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    VStack(spacing: -20) {
                        HStack(spacing: 22) {
                            Text("min")
                            Text("sec")
                        }
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        HStack(spacing: -15) {
                            SelectionView(
                                choiceNumber: $traningTimeInMinutes,
                                range: 0...60
                            )
                            SelectionView(
                                choiceNumber: $traningTimeInSeconds,
                                range: 0...60
                            )
                        }
                    }
                }
                .foregroundColor(Color("ActionColor"))
                VStack {
                    Text("REST")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    VStack(spacing: -20) {
                        HStack(spacing: 22) {
                            Text("min")
                            Text("sec")
                        }
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        HStack(spacing: -15) {
                            SelectionView(
                                choiceNumber: $restTimeInMinutes,
                                range: 0...60)
                            SelectionView(
                                choiceNumber: $restTimeInSeconds,
                                range: 0...60)
                        }
                    }
                }
                .foregroundColor(Color("ActionColor"))
            }
            if hintIsShow {
                HintView()
            }
            Spacer()
            Button(action: startTraining) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 50)
                        .foregroundColor(Color("ActionColor"))
                    Text("GO")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private func startTraining() {
        slots = TrainingManager().createWorkout(
            roundsCount: roundsCount,
            trainingTimeCount: trainingTimeCount,
            resrTimeCount: resrTimeCount
        )
        if !slots.isEmpty {
            UIApplication.shared.isIdleTimerDisabled = true
            withAnimation {
                setupIsHidden.toggle()
            }
        } else {
            withAnimation {
                hintIsShow = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    hintIsShow = false
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupWorkoutView(
            slots: .constant(Slot.defaultSlots),
            roundsCount: .constant(3),
            setupIsHidden: .constant(false),
            soundIsOn: .constant(true)
        )
    }
}
