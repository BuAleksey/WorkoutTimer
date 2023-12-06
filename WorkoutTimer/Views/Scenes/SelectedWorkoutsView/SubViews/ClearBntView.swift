//
//  ClearBntView.swift
//  WorkoutTimer
//
//  Created by Buba on 04.12.2023.
//

import SwiftUI

struct ClearBntView: View {
    @State private var shouldShake = false
    var action = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "trash.fill")
                .font(.title3)
                .foregroundColor(Color("AttentionColor"))
                .rotationEffect(Angle(degrees: shouldShake ? 7 : 0))
                .animation(Animation.default.speed(1).repeatCount(3), value: shouldShake)
                .onAppear {
                    shouldShake = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        shouldShake = false
                    }
                }
        }
    }
}

#Preview {
    ClearBntView()
}
