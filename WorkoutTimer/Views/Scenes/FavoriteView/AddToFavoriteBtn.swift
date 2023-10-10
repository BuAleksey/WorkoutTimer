//
//  AddToFavoriteBtn.swift
//  WorkoutTimer
//
//  Created by Buba on 13.11.2023.
//

import SwiftUI

struct AddToFavoriteBtn: View {
    var action = {}
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Add workout to favorites")
                    .foregroundStyle(Color.white)
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(Color("ActionColor"))
            }
        }
    }
}

#Preview {
    AddToFavoriteBtn()
}
