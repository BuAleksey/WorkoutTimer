//
//  MainViewNew.swift
//  WorkoutTimer
//
//  Created by Buba on 15.11.2023.
//

import SwiftUI

struct MainViewNew: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea()
                SetupWorkoutView()
            }
        }
    }
}

#Preview {
    MainViewNew()
}
