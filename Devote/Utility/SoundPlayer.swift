//
//  SoundPlayer.swift
//  Devote
//
//  Created by Andre Abtahi on 8/24/21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    // can add necessary sound file to audio player we want to play
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch{
            print("Could not find and play sound file. :(")
        }
    }
}
