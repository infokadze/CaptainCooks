//
//  Extensions.swift
//  CaptainCooks
//
//  Created by Harry Crocks on 1/8/22.
//

import UIKit
import AVFoundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension UIViewController {
    func makeLabelChewyColor(label: UILabel, text: String, size: CGFloat) -> UILabel {
        let labelChanged = label
        let color = UIColor.rgbColor(red: 136, green: 50, blue: 54, alpha: 1)
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: -4.0,
                                                          .strokeColor: UIColor.white,
                                                          .foregroundColor: color]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        labelChanged.attributedText = attributedString
        labelChanged.font = UIFont(name: "Chewy-Regular", size: size)
        return labelChanged
    }
    
    func makeChewyTextView(textView: UITextView, text: String, size: CGFloat) -> UITextView {
        let textForView = textView
//        let color = UIColor.rgbColor(red: 136, green: 50, blue: 54, alpha: 1)
        let color = UIColor.black
        let attributes: [NSAttributedString.Key : Any] = [.strokeWidth: -4.0,
                                                          .strokeColor: UIColor.white,
                                                          .foregroundColor: color]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        textView.attributedText = attributedString
        textView.font = UIFont(name: "Chewy-Regular", size: size)
        return textForView
    }
    
    func makeSettingsButtonImage(button: UIButton, image: UIImage, needsRendering: Bool) -> UIButton {
        let buttonChanged = button
        switch needsRendering {
        case true:
            let buttonChanged = button
            buttonChanged.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            buttonChanged.tintColor = UIColor.rgbColor(red: 232, green: 164, blue: 69, alpha: 1)
    case false:
        let buttonChanged = button
            buttonChanged.setImage(image, for: .normal)
    }
    return buttonChanged
    }
}

extension UILabel {
    func updateAttributedText(_ text: String) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.mutableString.setString(text)
            self.attributedText = mutableAttributedText
        }
    }
}

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
    
}

extension UIButton {
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
    
    func createIconShakeAnimation(fromValue: Float, toValue: Float, speed: Float? = nil, duration: CFTimeInterval? = nil) -> CABasicAnimation {
        var iconShake = CABasicAnimation()
        iconShake = CABasicAnimation(keyPath: "transform.rotation.z")
        iconShake.fromValue = fromValue
        iconShake.toValue = toValue
        iconShake.autoreverses = true
        iconShake.isRemovedOnCompletion = false
        iconShake.duration = duration ?? 1
        iconShake.speed = speed ?? 1
        iconShake.repeatCount = Float.greatestFiniteMagnitude
        return iconShake
    }
}

extension UIViewController {
    
    func playBackgroundAudio(playerClassInstance: SoundManager, sound: SoundManager.SoundEffect) {
        let player = playerClassInstance
        player.playSound(effect: sound)
        player.audioPlayer?.numberOfLoops = -1
        player.audioPlayer?.volume = 1
    }
    
    func playSoundOneTimer(playerClassInstance: SoundManager, sound: SoundManager.SoundEffect) {
        let player = playerClassInstance
        player.playSound(effect: sound)
        player.audioPlayer?.numberOfLoops = 1
        player.audioPlayer?.volume = 1
    
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

extension UIView {
    enum GlowEffect: Float {
        case small = 4, normal = 8, big = 15
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal, duration: CFTimeInterval? = nil) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero

        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime()+0.3
        glowAnimation.duration = duration ?? 1.5
        glowAnimation.isRemovedOnCompletion = false
        glowAnimation.repeatCount = .infinity
        glowAnimation.fillMode = .removed
        glowAnimation.autoreverses = true
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
}

extension UIButton {

    #warning("needs testing")
    func flash() {
        // Take as snapshot of the button and render as a template
        let snapshot = self.snapshot?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: snapshot)
        // Add it image view and render close to white
        imageView.tintColor = UIColor(white: 0.9, alpha: 1.0)
        guard let image = imageView.snapshot  else { return }
        let width = image.size.width
        let height = image.size.height
        // Create CALayer and add light content to it
        let shineLayer = CALayer()
        shineLayer.contents = image.cgImage
        shineLayer.frame = bounds

        // create CAGradientLayer that will act as mask clear = not shown, opaque = rendered
        // Adjust gradient to increase width and angle of highlight
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.black.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.35, 0.50, 0.65, 0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        gradientLayer.frame = CGRect(x: -width, y: 0, width: width, height: height)
        // Create CA animation that will move mask from outside bounds left to outside bounds right
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.byValue = width * 2
        // How long it takes for glare to move across button
        animation.duration = 3
        // Repeat forever
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        layer.addSublayer(shineLayer)
        shineLayer.mask = gradientLayer

        // Add animation
        gradientLayer.add(animation, forKey: "shine")
    }

    func stopFlash() {
        // Search all sublayer masks for "shine" animation and remove
        layer.sublayers?.forEach {
            $0.mask?.removeAnimation(forKey: "shine")
        }
    }
}

extension UIView {
    // Helper to snapshot a view
    var snapshot: UIImage? {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)

        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
}

extension UIView{
     func blink() {
         self.alpha = 0.8
         UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut], animations: {self.alpha = 1.0}, completion: nil)
     }
}



#warning("check")
fileprivate enum Storyboard : String {
        case main = "Main"
    }

    fileprivate extension UIStoryboard {
        static func loadFromMain(_ identifier: String) -> UIViewController {
            return load(from: .main, identifier: identifier)
        }

        static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
            let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
            return uiStoryboard.instantiateViewController(withIdentifier: identifier)
        }
    }

    // MARK: App View Controllers

    extension UIStoryboard {
        class func loadHomeViewController() ->  InitialViewController {
            return loadFromMain("HomeViewController") as! InitialViewController
        }
    }

