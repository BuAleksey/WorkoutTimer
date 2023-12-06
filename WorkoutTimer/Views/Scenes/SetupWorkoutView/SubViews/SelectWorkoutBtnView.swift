//
//  SelectedWorkoutBtnView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct SelectWorkoutBtnView: View {
    @State private var scale: CGFloat = 1.3
    @State private var color = Color(.gold)
    
    var body: some View {
        Image(systemName: "star.fill")
            .font(.title)
            .foregroundColor(color)
            .scaleEffect(scale)
            .animation(
                .linear(duration: 1).repeatCount(3),
                value: scale)
            .onAppear {
                scale = 1.3
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    scale = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    color = .action
                }
            }
    }
}

#Preview {
    SelectWorkoutBtnView()
}
