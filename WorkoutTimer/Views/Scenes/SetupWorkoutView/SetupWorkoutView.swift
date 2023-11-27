//
//  SetupWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct SetupWorkoutView: View {
    @State private var workout = Workout.defaultWorkout
    @State private var soundIsOn = true
    
    @State private var favoritesViewIsShow = false
    @State private var settingsIsShow = false
    
    @State private var hintIsShow = false
    @State private var showAddToFavoritesBtn = false
    @State private var navigationLinkIsActive = false
    
    @State private var selectedWorkout = Workout.defaultWorkout
    
    @State private var numberOfRounds = 1
    @State private var workTimeMinutes = 0
    @State private var workTimeSeconds = 0
    @State private var restTimeMinutes = 0
    @State private var restTimeSeconds = 0
    
    private var workTimeCount: Int {
        workTimeMinutes * 60 + workTimeSeconds
    }
    private var restTimeCount: Int {
        restTimeMinutes * 60 + restTimeSeconds
    }
    private let timePresent = TimePresent.shared
    
    var body: some View {
        VStack {
            HStack {
                FavoriteBtnView()
                    .onTapGesture { favoritesViewIsShow.toggle() }
                    .sheet( isPresented: $favoritesViewIsShow) {
                        FavoritesView(
                            viewIsVisible: $favoritesViewIsShow,
                            workout: $workout,
                            selectedWorkout: $selectedWorkout
                        )
                    }
                
                Spacer()
                
                SettingsBtnView()
                    .onTapGesture { settingsIsShow.toggle() }
                    .sheet(isPresented: $settingsIsShow) {
                        SettingsView(
                            viewIsVisible: $settingsIsShow,
                            soundIsOn: $soundIsOn
                        )
                    }
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
                    PickerView(choiceNumber: $numberOfRounds)
                }
                .onChange(of: numberOfRounds) { _ in
                    showAddToFavoritesBtn = true
                }
                
                SelectionView(
                    timeMinutes: $workTimeMinutes,
                    timeSeconds: $workTimeSeconds,
                    title: "WORK"
                )
                .onChange(of: workTimeCount) { _ in
                    showAddToFavoritesBtn = true
                }
                
                SelectionView(
                    timeMinutes: $restTimeMinutes,
                    timeSeconds: $restTimeSeconds,
                    title: "REST"
                )
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
            
            NavigationLink("", isActive: $navigationLinkIsActive) {
                TimerScrollView(
                    workout: $workout,
                    soundIsOn: $soundIsOn,
                    navigationLinkIsActive: $navigationLinkIsActive,
                    numberOsRounds: numberOfRounds
                )
            }
            .hidden()
            
            Spacer()
        }
        .onChange(of: selectedWorkout) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    setWorkoutParametrs()
                }
            }
        }
        .padding()
    }
}
    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupWorkoutView()
    }
}

//MARK: - Private metods
extension SetupWorkoutView {
    private func startWorkout() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
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
        navigationLinkIsActive.toggle()
    }
    
    private func addToFavorites() {
        guard let workout = WorkoutManager.shared.createWorkout(
            numberOfRounds: numberOfRounds,
            workTimeCount: workTimeCount,
            restTimeCount: restTimeCount
        ) else { return }
        DataManager.shared.addWorkoutToFavorites(workout)
        showAddToFavoritesBtn = false
    }
    
    private func setWorkoutParametrs() {
        numberOfRounds = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).numberOfRounds
        workTimeMinutes = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).workTime.min
        workTimeSeconds = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).workTime.sec
        restTimeMinutes = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).restTime.min
        restTimeSeconds = timePresent.setWorkoutParametrs(
            selectedWorkout
        ).restTime.sec
    }
}
