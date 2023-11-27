//
//  MainView.swift
//  WorkoutTimer
//
//  Created by Buba on 15.11.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea(.all)
                SetupWorkoutView()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MainView()
}
