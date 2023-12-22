//
//  AddToSelectedWorkoutBtn.swift
//  WorkoutTimer
//
//  Created by Buba on 13.11.2023.
//

import SwiftUI

struct AddToSelectedWorkoutBtn: View {
    var action = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.inversionAccentColor)
                    .font(.title2)
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.textColor)
                    .font(.system(size: 10))
            }
        }
        .frame(width: 100)
    }
}
