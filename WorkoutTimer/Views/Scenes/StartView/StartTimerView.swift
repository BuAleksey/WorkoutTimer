//
//  StartTimerView.swift
//  WorkoutTimer
//
//  Created by Buba on 20.12.2023.
//

import SwiftUI

struct StartTimerView: View {
    @State private var showBlur = false
    @State private var isHighlighted = false
    
    var body: some View {
        ZStack {
            Color.accentColor
            
            HStack(spacing: -10) {
                    Spacer()
                    Text("00")
                    Text(":")
                    .opacity(isHighlighted ? 1 : 0.3)
                    .animation(.easeInOut.repeatCount(4), value: isHighlighted)
                    Text("00")
                    Spacer()
            }
            .font(.custom("CursedTimerUlil", size: 100))
            .foregroundStyle(Color.inversionAccentColor)
            .shadow(color: .black, radius: 3, x: 3, y: 3)
            
            if showBlur {
                VisualEffectBlur()
                    .opacity(0.9)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            isHighlighted.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeInOut(duration: 1)) {
                    showBlur.toggle()
                }
            }
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: .systemChromeMaterial)
    }
}
