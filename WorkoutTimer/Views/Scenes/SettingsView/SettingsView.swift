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
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                Text("SETTINGS")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                    .frame(height: 50)
                HStack {
                    Toggle("Sound", isOn: $soundIsOn)
                        .tint(Color("ActionColor"))
                }
                Spacer()
            }
            .foregroundColor(Color("ActionColor"))
            .font(.system(size: 15, weight: .bold, design: .rounded))
            .padding()
        }
    }
}

#Preview {
    SettingsView(viewIsVisible: .constant(true), soundIsOn: .constant(true))
}
