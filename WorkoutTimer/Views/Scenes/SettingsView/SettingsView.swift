//
//  SettingsView.swift
//  WorkoutTimer
//
//  Created by Buba on 25.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Toggle("Sound", isOn: $dataManager.audioIsOn)
                            .tint(.textColor)
                    }
                    HStack {
                        Toggle("Vibrate", isOn: $dataManager.impactIsOn)
                            .tint(.textColor)
                    }
                }
                .foregroundStyle(Color.inversionAccentColor)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Spacer()
            }
            .padding()
        }
    }
}
