//
//  SelectionView.swift
//  WorkoutTimer
//
//  Created by Buba on 13.09.2023.
//

import SwiftUI

struct SelectionView: View {
    @Binding var choiceNumber: Int
    
    var body: some View {
        HStack {
            Button(action: { choiceNumber -= 1 }) {
                Image(systemName: "arrow.down.square.fill")
            }
            Text(choiceNumber.formatted())
            Button(action: { choiceNumber += 1 }) {
                Image(systemName: "arrow.up.square.fill")
            }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(choiceNumber: .constant(5))
    }
}
