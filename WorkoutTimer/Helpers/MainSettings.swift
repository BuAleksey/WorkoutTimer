//
//  MainSettings.swift
//  WorkoutTimer
//
//  Created by Buba on 03.12.2023.
//

import Foundation

final class MainSettings: ObservableObject {
    static let shared = MainSettings()
    
    @Published var soundIsOn = true
    @Published var vibrateIsOn = true
    
    private init() {}
}
