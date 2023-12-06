//
//  HorizontalCapView.swift
//  WorkoutTimer
//
//  Created by Buba on 04.12.2023.
//

import SwiftUI

struct HorizontalCapView: View {
    var width: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 10)
            .foregroundStyle(Color.clear)
    }
}

#Preview {
    HorizontalCapView(width: 100)
}
