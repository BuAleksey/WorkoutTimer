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
            HStack {
                Text("Save workout")
                    .foregroundStyle(Color.white)
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundStyle(Color("ActionColor"))
            }
        }
    }
}

#Preview {
    AddToSelectedWorkoutBtn()
}
