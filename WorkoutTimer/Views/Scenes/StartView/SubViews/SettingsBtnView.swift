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
            .foregroundStyle(Color.inversionAccentColor)
            .rotationEffect(Angle(degrees: rotation))
            .animation(
                .linear(duration: 2),
                value: rotation)
            .onAppear { 
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    rotation = 50
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        rotation = 0
                    }
                }
            }
    }
}
