//
//  HintView.swift
//  WorkoutTimer
//
//  Created by Buba on 20.09.2023.
//

import SwiftUI

struct HintView: View {
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 15))
                .foregroundColor(.yellow)
            Text("Set time of training")
                .foregroundColor(.white)
                .font(.system(size: 15, design: .rounded))
        }
        .frame(height: 60)
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        HintView()
    }
}
