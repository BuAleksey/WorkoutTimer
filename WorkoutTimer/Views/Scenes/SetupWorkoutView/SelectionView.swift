//
//  SelectionView.swift
//  WorkoutTimer
//
//  Created by Buba on 13.09.2023.
//

import SwiftUI

struct SelectionView: View {
    @Binding var choiceNumber: Int
    var range = 1...100
    
    var body: some View {
        Picker("Rounds count", selection: $choiceNumber) {
            ForEach(range, id: \.self) { number in
                Text(number.formatted())
                    .foregroundColor(Color("ActionColor"))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 70, height: 80)
        .clipped()
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(choiceNumber: .constant(5))
    }
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: UIView.noIntrinsicMetric
        )
    }
}
