//
//  VertycalCapView.swift
//  WorkoutTimer
//
//  Created by Buba on 14.11.2023.
//

import SwiftUI

struct VertycalCapView: View {
    var height: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: height)
            .foregroundStyle(Color.clear)
    }
}

#Preview {
    VertycalCapView(height: 50)
}
