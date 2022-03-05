//
//  Extensions.swift
//  CaptainCooks
//
//  Created by Harry Crocks on 1/8/22.
//

import UIKit
import AVFoundation

extension UIView {
    func startRotating(duration: Double = 0.5, randomRotationPath: Bool = Bool.random()) {

        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.autoreverses = true
            animate.repeatCount = 0
            
            animate.speed = 1
            animate.fromValue = 0
            
            if randomRotationPath {
            animate.toValue = 1
            } else {
                animate.toValue = -1
            }
            self.layer.add(animate, forKey: kAnimationKey)
            
        }
    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
         
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}

extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

}

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
    func makeLabelChewyColor(label: UILabel, text: String, size: CGFloat, color: UIColor) -> UILabel {
        let labelChanged = label
        let color = color
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
        let color = Constants.purpleColor
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
        case small = 4, normal = 8, big = 15, bigger = 25, evenBigger = 50
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

extension UIView{
     func blink() {
         self.alpha = 0.8
         UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut], animations: {self.alpha = 1.0}, completion: nil)
     }
}

extension UIViewController {
    
    func playBackgroundAudio(playerClassInstance: SoundManager, sound: SoundManager.SoundEffect) {
        if UserDefault.isBackgroundMusicOn {
        let player = playerClassInstance
        player.playSoundEffect(effect: sound)
        player.audioEffectsPlayer?.volume = 1
        player.audioEffectsPlayer?.numberOfLoops = -1
    }
}
    
    func stopBackgroundAudio(playerClassInstance: SoundManager, sound: SoundManager.SoundEffect) {
        let player = playerClassInstance
        player.stop()
    }
    
    func playSoundOneTimer(playerClassInstance: SoundManager, sound: SoundManager.SoundEffect) {
        if UserDefault.isSoundOn {
        let player = playerClassInstance
        player.playSoundEffect(effect: sound)
        player.audioEffectsPlayer?.volume = 1
        }
    }
    
}

extension UIViewController {
    
    func setOrientation(orientation: UIInterfaceOrientationMask) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.orientationLock = orientation
    }
}

extension UIView {
    
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}

extension Int {
    static func random(in range: ClosedRange<Int>, excluding x: Int) -> Int {
        if range.contains(x) {
            let r = Int.random(in: Range(uncheckedBounds: (range.lowerBound, range.upperBound)))
            return r == x ? range.upperBound : r
        } else {
            return Int.random(in: range)
        }
    }
}

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}

