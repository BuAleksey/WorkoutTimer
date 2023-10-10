//
//  SetupWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct SetupWorkoutView: View {
    @Binding var workout: Workout
    @Binding var roundsCount: Int
    @Binding var setupIsHidden: Bool
    @Binding var soundIsOn: Bool
    
    @State private var selectedFavoriteWorkout = Workout.defaultWorkout
    
    @State private var traningTimeInMinutes = 0
    @State private var traningTimeInSeconds = 0
    
    @State private var restTimeInMinutes = 0
    @State private var restTimeInSeconds = 0
    
    @State private var hintIsShow = false
    @State private var settingsIsShow = false
    @State private var showAddToFavoriteBtn = false
    @State private var favoriteIsShow = false
    
    private var trainingTimeCount: Int {
        traningTimeInMinutes * 60 + traningTimeInSeconds
    }
    private var restTimeCount: Int {
        restTimeInMinutes * 60 + restTimeInSeconds
    }
    
    var body: some View {
        VStack {
            HStack {
                FavoriteBtnView()
                    .onTapGesture {
                        favoriteIsShow.toggle()
                    }
                    .sheet(isPresented: $favoriteIsShow, content: {
                        FavoriteView(
                            viewIsVisible: $favoriteIsShow,
                            choice: $selectedFavoriteWorkout
                        )
                    })
                Spacer()
                SettingsBtnView()
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
                HStack(spacing: -3) {
                    VStack(spacing: 8) {
                        Text("ROUNDS")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        SelectionView(choiceNumber: $roundsCount)
                    }
                    VStack {
                        Text("TRAINING")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        VStack(spacing: -10) {
                            HStack(spacing: 32) {
                                Text("min")
                                Text("sec")
                            }
                            .font(.system(size: 15, weight: .light, design: .rounded))
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
                    .onChange(of: trainingTimeCount) { _ in
                        showAddToFavoriteBtn = true
                    }
                    
                    VStack {
                        Text("REST")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        VStack(spacing: -10) {
                            HStack(spacing: 32) {
                                Text("min")
                                Text("sec")
                            }
                            .font(.system(size: 15, weight: .light, design: .rounded))
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
                    .onChange(of: restTimeCount) { _ in
                        showAddToFavoriteBtn = true
                    }
            }
            .foregroundColor(Color("ActionColor"))
            
            if trainingTimeCount != 0 {
                AddToFavoriteBtn(action: addToFavorites)
                    .onAppear { showAddToFavoriteBtn = true }
                    .frame(height: 40)
                    .scaleEffect(showAddToFavoriteBtn ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 0.5),
                        value: showAddToFavoriteBtn
                    )
            } else {
                VertycallyCapView(height: 40)
            }
            
            Spacer()
            
            if hintIsShow {
                HintView()
            } else {
                VertycallyCapView(height: 60)
            }
            
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
        guard let workout = TrainingManager().createWorkout(
            roundsCount: roundsCount,
            trainingTimeCount: trainingTimeCount,
            resrTimeCount: restTimeCount
        ) else { 
            withAnimation {
                hintIsShow = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    hintIsShow = false
                }
            }
            return
        }
        self.workout = workout
        setupIsHidden.toggle()
    }
    
    private func addToFavorites() {
        guard let workout = TrainingManager().createWorkout(
            roundsCount: roundsCount,
            trainingTimeCount: trainingTimeCount,
            resrTimeCount: restTimeCount
        ) else { return }
        DataManager.shared.addFavoriteWorkout(workout)
        showAddToFavoriteBtn = false
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupWorkoutView(
            workout: .constant(Workout.defaultWorkout),
            roundsCount: .constant(3),
            setupIsHidden: .constant(false),
            soundIsOn: .constant(true)
        )
    }
}
