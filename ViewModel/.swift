//
//  SwiftUIView.swift
//  Ritmo
//
//  Created by Francisco Losada on 21/01/26.
//

import SwiftUI
import AVFoundation

struct AudioViewModel {
    func playAudio(soundName: String, audioPlayer: AVAudioPlayer?) {
        var player = audioPlayer
        guard let soundFile = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Error! Could not read file \(soundName)")
            return
        }
        
        do {
            try player = AVAudioPlayer(contentsOf: soundFile)
            audioPlayer?.play()
            print("entrou")
        } catch {
            print("ERROR!! \(error.localizedDescription) by creating auido player")
        }
    }
}
