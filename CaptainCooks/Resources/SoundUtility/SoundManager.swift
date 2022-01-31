//
//  SoundManager.swift
//  CardMatchGame
//
//  Created by LiewSyetChau on 16/12/21.
//

import AVFoundation

final class SoundManager {
    
    static let sharedAudioBackgroundObject = SoundManager()
    static let sharedAudioOneTimerObject = SoundManager()
    
    var audioEffectsPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
        case sad
        case main
        case slots
        case click
        case coins
        case spin
        case plusOrMinus
    }
    
    func playSoundEffect(effect: SoundEffect) {
        
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
            case .click:
                soundFileName = "click2"
            case .coins:
                soundFileName = "coins"
            case .spin:
                soundFileName = "spin"
            case . plusOrMinus:
                soundFileName = "plusOrMinus"
            }
            
            let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
            
            guard bundlePath != nil else {
                return
            }
            
            let url = URL(fileURLWithPath: bundlePath!)
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
                audioEffectsPlayer = try AVAudioPlayer(contentsOf: url)
                
                //play the audio player
                audioEffectsPlayer?.play()
                
            } catch {
                print(error.localizedDescription)
                return
            }
        }
    
    func stop() {
        audioEffectsPlayer?.stop()
    }
}

extension AVAudioPlayer {
    
    /// Fades player volume FROM any volume TO any volume
    /// - Parameters:
    ///   - from: initial volume
    ///   - to: target volume
    ///   - duration: duration in seconds for the fade
    ///   - completion: callback indicating completion
    /// - Returns: Timer?
    func fadeVolume(from: Float, to: Float, duration: Float, completion: (() -> Void)? = nil) -> Timer? {
        
        // 1. Set Initial volume
        volume = from
        // 2. There's no point in continuing if target volume is the same as initial
        guard from != to else { return nil }
        // 3. We define the time interval the interaction will loop into (fraction of a second)
        let interval: Float = 0.1
        // 4. Set the range the volume will move
        let range = to-from
        // 5. Based on the range, the interval and duration, we calculate how big is the step we need to take in order to reach the target in the given duration
        let step = (range*interval)/duration
        
        // internal function whether the target has been reached or not
        func reachedTarget() -> Bool {
            // volume passed max/min
            guard volume >= 0, volume <= 1 else {
                volume = to
                return true
            }
            
            // checks whether the volume is going forward or backward and compare current volume to target
            if to > from {
                return volume >= to
            }
            return volume <= to
        }
        
        // 6. We create a timer that will repeat itself with the given interval
        return Timer.scheduledTimer(withTimeInterval: Double(interval), repeats: true, block: { [weak self] (timer) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                // 7. Check if we reached the target, otherwise we add the volume
                if !reachedTarget() {
                    // note that if the step is negative, meaning that the to value is lower than the from value, the volume will be decreased instead
                    self.volume += step
                } else {
                    timer.invalidate()
                    completion?()
                }
            }
        })
    }
}
