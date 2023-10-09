//
//  EmojiAnimatioView.swift
//  WorkoutTimer
//
//  Created by Buba on 02.10.2023.
//

import SwiftUI

struct EmojiAnimationView: View {
    var emojis = ["🦾", "💪🏻", "💪🏽"]
    
    var body: some View {
        ZStack {
            ForEach(emojis, id: \.self) { emoji in
                EmojiSetView(emoji: emoji)
            }
        }
    }
}

#Preview {
    EmojiAnimationView()
}

struct EmojiSetView: View {
    @State var emojiCount = Int.random(in: 1...20)
    var emoji: String
    
    var body: some View {
        ZStack {
            ForEach(0...emojiCount, id: \.self) { _ in
                EmojiView(emoji: emoji)
            }
        }
    }
}

struct EmojiView: View {
    @State var position = CGPoint(x: CGFloat.random(in: 20...340), y: CGFloat.random(in: 800...1300))
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var emoji: String
    
    var body: some View {
        ZStack {
            Text(emoji)
                .font(.system(size: 50))
                .position(position)
                .onReceive(timer, perform: { _ in
                    withAnimation(.spring(response: 1, dampingFraction: 5, blendDuration: 50)) {
                        guard let newPosition = sliding() else { return }
                        position.y = newPosition
                    }
                })
                .onDisappear(perform: {
                    timer.upstream.connect().cancel()
                })
        }
    }
    
    private func sliding() -> CGFloat? {
        let random = CGFloat.random(in: 2...100)
        if position.y != 0 {
            let newY = position.y - random
            return newY
        } else {
            timer.upstream.connect().cancel()
            return nil
        }
    }
}
