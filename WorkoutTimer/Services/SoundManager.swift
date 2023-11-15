//
//  SoundManager.swift
//  WorkoutTimer
//
//  Created by Buba on 21.09.2023.
//

import Foundation
import AVFoundation

final class SoundManager {
    private var audioPlayer: AVAudioPlayer!
    private let urlTrainingSound = Bundle.main.url(forResource: "work", withExtension: "mp3")!
    
    private func prepearToPlay(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playWorkSound() {
        prepearToPlay(url: urlTrainingSound)
    }
}
