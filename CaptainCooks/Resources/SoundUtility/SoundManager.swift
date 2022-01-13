//
//  SoundManager.swift
//  CardMatchGame
//
//  Created by LiewSyetChau on 16/12/21.
//

import AVFoundation

final class SoundManager {
    
    static let sharedInstance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
        
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
        case sad
        case main
        case slots
//        case harp
    }
    
    func playSound(effect: SoundEffect) {
        var soundFileName = ""
        
        switch effect {
            
        case .flip:
            soundFileName = "cardflip"
            break
        case .match:
            soundFileName = "dingcorrect"
            break
        case .nomatch:
            soundFileName = "dingwrong"
            break
        case .shuffle:
            soundFileName = "shuffle"
        case .sad:
            soundFileName = "sad"
            break
        case .main:
            soundFileName = "main"
            break
        case .slots:
            soundFileName = "slots"

        }
        
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
   
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            //play the audio player
            audioPlayer?.play()
            
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        UserDefault.isMutedBackgroundMusic = true
    }
}

