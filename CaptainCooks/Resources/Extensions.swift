//
//  Extensions.swift
//  CaptainCooks
//
//  Created by Harry Crocks on 1/8/22.
//

import UIKit
import AVFoundation

extension UIColor {
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}

extension UIButton {
    
    func changeImageAnimated(image: UIImage?) {
        guard let imageView = self.imageView, let currentImage = imageView.image, let newImage = image else {
            return
        }
        let crossFade: CABasicAnimation = CABasicAnimation(keyPath: "contents")
        crossFade.duration = 0.3
        crossFade.fromValue = currentImage.cgImage
        crossFade.toValue = newImage.cgImage
        crossFade.isRemovedOnCompletion = false
        crossFade.fillMode = CAMediaTimingFillMode.forwards
        imageView.layer.add(crossFade, forKey: "animateContents")
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIViewController {
    
    func setupBackgroundAudio(playerClassInstance: SoundManager, sound: SoundManager.SoundEffect) {
        let player = playerClassInstance
        player.playSound(effect: sound)
        player.audioPlayer?.numberOfLoops = -1
        player.audioPlayer?.volume = 1
    }
    
    func createIconShakeAnimation(fromValue: Float, toValue: Float, speed: Float? = nil) -> CABasicAnimation {
        var iconShake = CABasicAnimation()
        iconShake = CABasicAnimation(keyPath: "transform.rotation.z")
        iconShake.fromValue = fromValue
        iconShake.toValue = toValue
        iconShake.autoreverses = true
        iconShake.duration = 1
        iconShake.speed = speed ?? 1
        iconShake.repeatCount = Float.greatestFiniteMagnitude
        return iconShake
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

extension UIView {
    // ->1
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                  direction: Direction = .leftToRight,
                                  repeatCount: Float = MAXFLOAT) {
        
        // Create color  ->2
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor
        
        // Create a CAGradientLayer  ->3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
        self.layer.mask = gradientLayer
        
        // Add animation over gradient Layer  ->4
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
        self.layer.mask = nil
    }
    
}
