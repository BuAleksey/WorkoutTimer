//
//  SettingsView.swift
//  WorkoutTimer
//
//  Created by Buba on 25.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var viewIsVisible: Bool
    
    @Binding var soundIsOn: Bool
    @Binding var impactIsOn: Bool
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("SETTINGS")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    Spacer()
                        .frame(height: 50)
                    HStack {
                        Toggle("Sound", isOn: $soundIsOn)
                            .tint(Color("ActionColor"))
                    }
                    HStack {
                        Toggle("Vibrate", isOn: $impactIsOn)
                            .tint(Color("ActionColor"))
                    }
                }
                .foregroundColor(Color("ActionColor"))
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

#Preview {
    SettingsView(
        viewIsVisible: .constant(true),
        soundIsOn: .constant(true),
        impactIsOn: .constant(true)
    )
}
