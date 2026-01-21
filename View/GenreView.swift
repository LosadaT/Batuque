//
//  SwiftUIView.swift
//  Ritmo
//
//  Created by Francisco Losada on 20/01/26.
//

import SwiftUI
import AVFAudio

@available(iOS 17.0, *)
struct GenreView: View {
    @State var audioPlayer: AVAudioPlayer?
    @State var isPlaying: Bool = false
    
    var genre: String
    var image: String
    var text: String
    var audio: String
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(genre)
                        .textColor()
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    Spacer()
                }
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.8
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                HStack {
                    Button {
                        playAudio(soundName: audio)
                    } label: {
                        Image(systemName: !isPlaying ?  "play.fill" : "pause.fill")
                            .foregroundStyle(Color(hex: 0x136900))
                            .padding(8)
                            .background(.white.opacity(0.5))
                            .clipShape(Circle())
                    }
                    //.padding(.trailing)
                    Text(!isPlaying ? "Play" : "Pause")
                        .textColor()
                        .font(.title3)
    
                    Spacer()
                }
                .font(.title3)
                .padding(10)
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.8
                }
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Text(text)
                    .textColor()
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .onChange(of: genre) {
                pauseAudio()
            }
        }
    }
    
    func playAudio(soundName: String) {
        guard let soundFile = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Error! Could not read file \(soundName)")
            return
        }
        
        if isPlaying {
            audioPlayer?.pause()
            isPlaying = false
        }
        else {
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: soundFile)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
                isPlaying = true
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        GenreView(genre: "Axé", image: "axe", text: "Axé, or axé music, is a musical genre that emerged in the state of Bahia in the 1980s during the popular celebrations of Salvador's Carnival, mixing samba-reggae,[1] frevo, samba duro,[1] samba afro,[2] ijexá[3] and other Candomblé rhythms,[4] pop rock,[5][6] as well as other Afro-Brazilian and Afro-Latin rhythms.", audio: "axe")
    } else { }
}
