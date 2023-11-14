//
//  FinishView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct FinishView: View {
    @Binding var viewIsVisibly: Bool
    @State private var textTitle = "FINISH"
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            Text(textTitle)
                .foregroundColor(Color("ActionColor"))
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            textTitle = "IT'S AMAZING"
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            viewIsVisibly.toggle()
                        }
                    }
                }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(viewIsVisibly: .constant(true))
    }
}
