//
//  SettingsBtnView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct SettingsBtnView: View {
    @State private var rotation = 0.0
    
    var body: some View {
        Image(systemName: "gear")
            .font(.title)
            .foregroundColor(Color("ActionColor"))
            .rotationEffect(Angle(degrees: rotation))
            .animation(
                .linear(duration: 2),
                value: rotation)
            .onAppear { 
                rotation = 50
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    rotation = 0
                }
            }
    }
}

#Preview {
    SettingsBtnView()
}
