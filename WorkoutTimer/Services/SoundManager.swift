//
//  SoundManager.swift
//  WorkoutTimer
//
//  Created by Buba on 21.09.2023.
//

import Foundation
import AVFoundation

final class SoundManager {
    static let shared = SoundManager()
    
    private var audioPlayer: AVAudioPlayer!
    private let urlWorkSound = Bundle.main.url(forResource: "work", withExtension: "mp3")!
    private let urlRestSound = Bundle.main.url(forResource: "rest", withExtension: "mp3")!
    private let url10SecSound = Bundle.main.url(forResource: "10sec", withExtension: "mp3")!
    
    func playWorkSound() {
        prepearToPlay(url: urlWorkSound)
    }
    
    func playRestSound() {
        prepearToPlay(url: urlRestSound)
    }
    
    func play10SecSound() {
        prepearToPlay(url: url10SecSound)
    }
    
    func stop() {
        audioPlayer.stop()
    }
    
    private init() {}
    
    private func prepearToPlay(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
