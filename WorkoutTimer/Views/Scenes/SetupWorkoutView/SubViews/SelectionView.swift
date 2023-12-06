//
//  SelectionView.swift
//  WorkoutTimer
//
//  Created by Buba on 13.09.2023.
//

import SwiftUI

struct SelectionView: View {
    @Binding var timeMinutes: Int
    @Binding var timeSeconds: Int
    
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            VStack(spacing: -10) {
                HStack(spacing: 32) {
                    Text("min")
                    Text("sec")
                }
                .font(.system(size: 15, weight: .light, design: .rounded))
                HStack(spacing: -15) {
                    PickerView(
                        choiceNumber: $timeMinutes,
                        range: 0...60
                    )
                    PickerView(
                        choiceNumber: $timeSeconds,
                        range: 0...60
                    )
                }
            }
        }
    }
}

struct PickerView: View {
    @Binding var choiceNumber: Int
    var range = 1...100
    
    var body: some View {
        Picker("", selection: $choiceNumber) {
            ForEach(range, id: \.self) { number in
                Text(number.formatted())
                    .foregroundColor(.action)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 70, height: 80)
        .clipped()
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
