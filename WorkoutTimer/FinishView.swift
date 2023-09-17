//
//  FinishView.swift
//  WorkoutTimer
//
//  Created by Buba on 17.09.2023.
//

import SwiftUI

struct FinishView: View {
    @Binding var viewIsVisibly: Bool
    @State var text = "FINISH"
    
    var body: some View {
        Text(text)
            .foregroundColor(Color("ActionColor"))
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                       text = "IT'S AMAZING"
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

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(viewIsVisibly: .constant(true))
    }
}
