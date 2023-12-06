//
//  SettingsView.swift
//  WorkoutTimer
//
//  Created by Buba on 25.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var mainSettings: MainSettings
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Text("SETTINGS")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    Spacer()
                        .frame(height: 50)
                    HStack {
                        Toggle("Sound", isOn: $mainSettings.soundIsOn)
                            .tint(.action)
                    }
                    HStack {
                        Toggle("Vibrate", isOn: $mainSettings.vibrateIsOn)
                            .tint(.action)
                    }
                }
                .foregroundColor(.action)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Spacer()
                
                Text("""
                         Contact information:
                         oldf03@gmail . com
                         """)
                .foregroundStyle(Color.white)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                
                Spacer()
                    .frame(height: 50)
            }
            .padding()
        }
    }
}
