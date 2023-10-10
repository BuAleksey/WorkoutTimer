//
//  FavoriteBtnView.swift
//  WorkoutTimer
//
//  Created by Buba on 11.10.2023.
//

import SwiftUI

struct FavoriteBtnView: View {
    @State private var scale: CGFloat = 1.3
    
    var body: some View {
        Image(systemName: "heart")
            .font(.title)
            .foregroundColor(Color("ActionColor"))
            .scaleEffect(scale)
            .animation(
                .linear(duration: 1).repeatCount(3),
                value: scale)
            .onAppear { scale = 1 }
    }
}

#Preview {
    FavoriteBtnView()
}
