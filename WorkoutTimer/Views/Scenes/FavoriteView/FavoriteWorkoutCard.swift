//
//  FavoriteWorkoutCard.swift
//  WorkoutTimer
//
//  Created by Buba on 14.11.2023.
//

import SwiftUI

struct FavoriteWorkoutCard: View {
    var numberOfRounds = "5"
    var workTime = "3:00"
    var raseTime = "0:40"
    var action = {}
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.accentColor)
                .frame(width: UIScreen.main.bounds.width / 2 - 42, height: 180)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                }
            
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: action) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 2 - 30)
                    Spacer()
                }
                .frame(height: 190)
                
                VStack {
                    Text("ROUNDS")
                        .font(.system(
                            size: 15,
                            weight: .regular,
                            design: .rounded
                        ))
                    Text("\(numberOfRounds)")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 10)
                    
                    HStack {
                        VStack {
                            Text("WORK")
                                .font(.system(
                                    size: 15,
                                    weight: .regular,
                                    design: .rounded
                                ))
                            Text("\(workTime)")
                                .font(.system(
                                    size: 15,
                                    weight: .heavy,
                                    design: .rounded
                                ))
                                .foregroundStyle(Color.white)
                        }
                        
                        VStack {
                            Text("RASE")
                                .font(.system(
                                    size: 15,
                                    weight: .regular,
                                    design: .rounded
                                ))
                            Text("\(raseTime)")
                                .font(.system(
                                    size: 15,
                                    weight: .heavy,
                                    design: .rounded
                                ))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .foregroundStyle(Color("ActionColor"))
            }
        }
    }
}

#Preview {
    FavoriteWorkoutCard()
}
