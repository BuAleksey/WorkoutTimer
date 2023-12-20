//
//  SetupWorkoutView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct SetupWorkoutView: View {
    @StateObject private var viewModel = SetupWorkoutViewModel.shared
    
    var body: some View {
        VStack {
            HStack {
                if viewModel.selectedWorkoutIsEmpty {
                    HorizontalCapView(width: 30)
                } else {
                    SelectWorkoutBtnView()
                        .onTapGesture { viewModel.selectedWorkoutViewIsShow.toggle() }
                        .sheet(isPresented: $viewModel.selectedWorkoutViewIsShow) {
                            SelectedWorkoutView(
                                viewIsVisible: $viewModel.selectedWorkoutViewIsShow
                            )
                        }
                }
                
                Spacer()
                
                SettingsBtnView()
                    .onTapGesture { viewModel.settingsViewIsShow.toggle() }
                    .sheet(isPresented: $viewModel.settingsViewIsShow) {
                        SettingsView()
                    }
            }
            
            Spacer()
            
            Text("LET'S START WORKOUT")
                .foregroundColor(.action)
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Spacer()
            HStack(spacing: -3) {
                VStack(spacing: 8) {
                    Text("ROUNDS")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    PickerView(choiceNumber: $viewModel.numberOfRounds)
                }
                .onChange(of: viewModel.numberOfRounds) { _ in
                    viewModel.makeWorkout()
                    viewModel.checkWorkoutInSelected()
                }
                
                SelectionView(
                    timeMinutes: $viewModel.workTimeMinutes,
                    timeSeconds: $viewModel.workTimeSeconds,
                    title: "WORK"
                )
                .onChange(of: viewModel.workTimeMinutes) { _ in
                    viewModel.makeWorkout()
                    viewModel.checkWorkoutInSelected()
                }
                .onChange(of: viewModel.workTimeSeconds) { _ in
                    viewModel.makeWorkout()
                    viewModel.checkWorkoutInSelected()
                }
                
                SelectionView(
                    timeMinutes: $viewModel.restTimeMinutes,
                    timeSeconds: $viewModel.restTimeSeconds,
                    title: "REST"
                )
                .onChange(of: viewModel.restTimeMinutes) { _ in
                    viewModel.makeWorkout()
                    viewModel.checkWorkoutInSelected()
                }
                .onChange(of: viewModel.restTimeSeconds) { _ in
                    viewModel.makeWorkout()
                    viewModel.checkWorkoutInSelected()
                }
            }
            .foregroundColor(.action)
            
            ZStack {
                VertycalCapView(height: 40)
                if viewModel.showAddToSelectedWorkoutBtn {
                    AddToSelectedWorkoutBtn(action: viewModel.addToSelectedWorkout)
                        .frame(height: 40)
                }
            }
            
            Spacer()
            
            ZStack {
                VertycalCapView(height: 60)
                if viewModel.hintIsShow {
                    HintView()
                        .offset(x: -10)
                }
            }
            
            Button(action: viewModel.startWorkout) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 50)
                        .foregroundColor(.action)
                    Text("GO")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                }
            }
            
            NavigationLink("", isActive: $viewModel.navigationLinkIsActive) {
                TimerScrollView(
                    navigationLinkIsActive: $viewModel.navigationLinkIsActive
                )
            }
            .hidden()
            
            Spacer()
        }
        .onAppear { viewModel.checkWorkoutInSelected() }
        .onChange(of: viewModel.setWorkoutFromSelected) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    viewModel.setWorkoutParametrs()
                }
            }
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SetupWorkoutView().preferredColorScheme(.dark)
    }
}
