//
//  BonusMapController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 05.01.2022.
//

import UIKit

final class BonusMapController: UIViewController {
    
    let cardAudioEffect = SoundManager()
    
    var particle1 = CAEmitterCell()
    var particle2 = CAEmitterCell()
    var particle3 = CAEmitterCell()

    @IBOutlet weak var bonusMapBackground: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var levelButtons: [UIButton]!
    
    @IBOutlet var levelCrosses: [UIImageView]!
    
    
    //MARK: - Button Actions
    @IBAction func menuButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
        self.view.window?.rootViewController?.dismiss(animated: false) {
        }
    }
    
    private func transitionCrossImageAnimation(fromImageView: UIImageView, toImageView: UIImageView) {
        UIView.transition(with: fromImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            fromImageView.image = toImageView.image
        }, completion: nil)
    }
    
    private func buttonImageOpacityChange(button: UIButton, toOpacity: Float)  {
        UIView.animate(withDuration: 0.5) {
            button.layer.opacity = toOpacity
        }
    }
    
    private func inactivateButtonAndImageViewAnimations(button: [UIButton], index: Int, imageView: [UIImageView]) {
        let buttonToSwitchOff = button[index]
        let imageToSwitchOff = imageView[index]
        
        buttonToSwitchOff.layer.removeAllAnimations()
        imageToSwitchOff.layer.removeAllAnimations()
        buttonToSwitchOff.stopShimmeringAnimation()
        buttonToSwitchOff.isUserInteractionEnabled = false
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: bonusMapBackground.center.x, y: -50)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: bonusMapBackground.frame.size.width, height: 1)
        particleEmitter.emitterMode = .outline

        particle1 = makeEmitterCell(imageName: "pirateShip1", color: nil)
        particle2 = makeEmitterCell(imageName: "pirateShip2", color: nil)
        particle3 = makeEmitterCell(imageName: "pirateShip3", color: nil)

        particleEmitter.emitterCells = [particle1, particle2, particle3]
        bonusMapBackground.layer.addSublayer(particleEmitter)
    }

    func makeEmitterCell(imageName: String, color: UIColor? = nil) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 0.2
        cell.lifetime = 100
        cell.velocity = 20
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.scaleRange = 0.5
        cell.scaleSpeed = 0.05
        
        cell.contents = UIImage(named: "\(imageName)")?.resizeImage(targetSize:CGSize(width: 20, height: 20)).cgImage
        
        return cell
    }
    
    #warning("Segue test")
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "goToMatchGame" {
//            return false
//        }
//        return false
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createParticles()
        levelCrosses.forEach {
            $0.layer.add(createIconShakeAnimation(fromValue: -0.1, toValue: 0.1), forKey: "iconShakeAnimation")
        }

        levelButtons.forEach {
            
            $0.layer.add(createIconShakeAnimation(fromValue: -0.1, toValue: 0.1), forKey: "iconShakeAnimation")
            
            levelButtons[0].tag = 1
            if $0.tag == 1 { return }
            
            $0.startShimmeringAnimation(animationSpeed: 2, direction: .leftToRight, repeatCount: .infinity)
            
            
        }
    }
    
    @IBAction func firstLevelBonusButton(_ sender: UIButton) {
        buttonImageOpacityChange(button: levelButtons[0], toOpacity: 0.75)
        
        transitionCrossImageAnimation(fromImageView: levelCrosses[0], toImageView: UIImageView.init(image: UIImage(named: "crossActive"))
        )
        
        inactivateButtonAndImageViewAnimations(button: levelButtons, index: 0, imageView: levelCrosses)
        _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 2, completion: nil)

#warning("write coins conditions")
//        strange if commented - still performs segue
        performSegue(withIdentifier: "goToMatchGame", sender: sender)
        
    }
    
    
    @IBAction func secondLevelBonusButton(_ sender: UIButton) {
        buttonImageOpacityChange(button: levelButtons[1], toOpacity: 0.75)
        
        transitionCrossImageAnimation(fromImageView: levelCrosses[1], toImageView: UIImageView.init(image: UIImage(named: "crossActiveRight"))
        )
        
        inactivateButtonAndImageViewAnimations(button: levelButtons, index: 1, imageView: levelCrosses)
        _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 2, completion: nil)
        
#warning("write coins conditions")
        
        performSegue(withIdentifier: "goToNotEnoughCoinsVC", sender: sender)
    }
    
    @IBAction func thirdLevelBonusButton(_ sender: UIButton) {
    }
    
    @IBAction func forthLevelBonusButton(_ sender: UIButton) {
    }
    
    @IBAction func fifthLevelBonusButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundAudio(playerClassInstance: SoundManager.sharedInstance, sound: .slots)

        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
}




