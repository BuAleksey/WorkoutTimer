//
//  HeadView.swift
//  WorkoutTimer
//
//  Created by Buba on 22.12.2023.
//

import SwiftUI

struct HeadView: View {
    @ObservedObject private var viewModel = MainViewModel.shared
    
    var body: some View {
        VStack {
            HStack {
                if !viewModel.selectedWorkoutIsEmpty {
                    SelectWorkoutBtnView(
                        action: viewModel.addToSelectedWorkoutBtnTapped
                    )
                    .sheet(
                        isPresented: $viewModel.selectedWorkoutViewIsShow) {
                            SelectedWorkoutView(
                                viewIsVisible:
                                    $viewModel.selectedWorkoutViewIsShow
                            )
                        }
                }
                
                Spacer()
                
                SettingsBtnView(action: viewModel.settingsBtnTapped)
                    .sheet(
                        isPresented: $viewModel.settingsViewIsShow) {
                            SettingsView()
                        }
            }
            Spacer()
        }
        .padding()
    }
}
