//
//  SelectedWorkoutBtnView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct SelectWorkoutBtnView: View {
    @State private var scale: CGFloat = 1.1
    @State private var color = Color(.gold)
    
    var action = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "star.fill")
                .font(.title)
                .foregroundStyle(color)
                .scaleEffect(scale)
                .animation(
                    .linear(duration: 1).repeatCount(2),
                    value: scale)
                .onAppear {
                    scale = 1.1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            scale = 1
                            color = .inversionAccentColor
                        }
                    }
                }
        }
    }
}
