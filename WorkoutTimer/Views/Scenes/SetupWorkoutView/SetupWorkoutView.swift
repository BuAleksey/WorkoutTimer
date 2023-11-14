//
//  SetupWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct SetupWorkoutView: View {
    @Binding var workout: Workout
    @Binding var numberOfRounds: Int
    @Binding var viewIsVisible: Bool
    @Binding var soundIsOn: Bool
    
    @State private var selectedFavoriteWorkout = Workout.defaultWorkout
    
    @State private var workTimeMinutes = 0
    @State private var workTimeSeconds = 0
    
    @State private var restTimeMinutes = 0
    @State private var restTimeSeconds = 0
    
    @State private var hintIsShow = false
    @State private var settingsIsShow = false
    @State private var showAddToFavoritesBtn = false
    @State private var favoritesViewIsShow = false
    
    private var workTimeCount: Int {
        workTimeMinutes * 60 + workTimeSeconds
    }
    private var restTimeCount: Int {
        restTimeMinutes * 60 + restTimeSeconds
    }
    
    var body: some View {
        VStack {
            HStack {
                FavoriteBtnView()
                    .onTapGesture {
                        favoritesViewIsShow.toggle()
                    }
                    .sheet(isPresented: $favoritesViewIsShow, content: {
                        FavoritesView(
                            viewIsVisible: $favoritesViewIsShow,
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
            Text("LET'S START WORKOUT")
                .foregroundColor(Color("ActionColor"))
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Spacer()
                HStack(spacing: -3) {
                    VStack(spacing: 8) {
                        Text("ROUNDS")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        SelectionView(choiceNumber: $numberOfRounds)
                    }
                    VStack {
                        Text("WORK")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        VStack(spacing: -10) {
                            HStack(spacing: 32) {
                                Text("min")
                                Text("sec")
                            }
                            .font(.system(size: 15, weight: .light, design: .rounded))
                            HStack(spacing: -15) {
                                SelectionView(
                                    choiceNumber: $workTimeMinutes,
                                    range: 0...60
                                )
                                SelectionView(
                                    choiceNumber: $workTimeSeconds,
                                    range: 0...60
                                )
                            }
                        }
                    }
                    .onChange(of: workTimeCount) { _ in
                        showAddToFavoritesBtn = true
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
                                    choiceNumber: $restTimeMinutes,
                                    range: 0...60)
                                SelectionView(
                                    choiceNumber: $restTimeSeconds,
                                    range: 0...60)
                            }
                    }
                }
                    .onChange(of: restTimeCount) { _ in
                        showAddToFavoritesBtn = true
                    }
            }
            .foregroundColor(Color("ActionColor"))
            
            if workTimeCount != 0 {
                AddToFavoriteBtn(action: addToFavorites)
                    .onAppear { showAddToFavoritesBtn = true }
                    .frame(height: 40)
                    .scaleEffect(showAddToFavoritesBtn ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 0.5),
                        value: showAddToFavoritesBtn
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
            
            Button(action: startWorkout) {
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
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SetupWorkoutView(
                workout: .constant(Workout.defaultWorkout),
                numberOfRounds: .constant(3),
                viewIsVisible: .constant(false),
                soundIsOn: .constant(true)
            )
        }
    }
}

//MARK: - Private metods
extension SetupWorkoutView {
    private func startWorkout() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            raseTimeCount: restTimeCount
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
        viewIsVisible.toggle()
    }
    
    private func addToFavorites() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            raseTimeCount: restTimeCount
        ) else { return }
        DataManager.shared.addWorkoutToFavorites(workout)
        showAddToFavoritesBtn = false
    }
}
