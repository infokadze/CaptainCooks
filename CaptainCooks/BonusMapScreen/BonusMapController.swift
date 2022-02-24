//
//  BonusMapController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 05.01.2022.
//

import UIKit
import CoreMedia

final class BonusMapController: UIViewController {
    
    @IBOutlet weak var bonusMapBackground: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var levelButtons: [UIButton]!
    @IBOutlet var levelCrosses: [UIImageView]!
    
    var particle1 = CAEmitterCell()
    var particle2 = CAEmitterCell()
    var particle3 = CAEmitterCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBonusLevel(level: UserDefault.bonusLevelNumber)
        createParticles()
    }
    
    //MARK: - Button Actions
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        present(vc, animated: true)
    }
    
      private func makeEmitterCell(imageName: String, color: UIColor? = nil) -> CAEmitterCell {
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
        
     private func createParticles() {
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
        
    private func buttonsDisableInteractonExcept(indexActive: Int) {
        let buttons = levelButtons.enumerated()
        for (_, value) in buttons where value.tag != indexActive {
            value.isEnabled = false
        }
    }
    
    private func filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: Int) {
        let buttons = levelButtons.enumerated()
        for (_, value) in buttons where value.tag != buttonAndCrossIndexExclusion {
            value.layer.add(createIconShakeAnimation(fromValue: 0.0, toValue: 0.05), forKey: "iconShakeAnimation") }
        
        
        let crosses = levelCrosses.enumerated()
        for (_, value) in crosses where value.tag != buttonAndCrossIndexExclusion {
            value.layer.add(createIconShakeAnimation(fromValue: 0.0, toValue: 0.05), forKey: "iconShakeAnimation")
            
            
            let activeLevel = levelButtons[buttonAndCrossIndexExclusion - 1]
            activeLevel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .big)
        }
    }
    
    private func loadBonusLevel(level: Int) {
        switch level {
        case 1:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 1)
            buttonsDisableInteractonExcept(indexActive: 1)
            UserDefault.bonusLevelNumber = level + 1
            
        case 2:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 2)
            buttonsDisableInteractonExcept(indexActive: 2)
            
            let buttons = levelButtons.enumerated()
            let crosses = levelCrosses.enumerated()
            
            for (_, value) in buttons where value.tag == 1 {
            value.setImage(UIImage(named: "treasure1000blured"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 2 {
            value.setImage(UIImage(named: "tryYourLuckActiveRight"), for: .normal)
            }
            
            for (_, value) in crosses where value.tag == 1 {
            value.image = UIImage(named: "crossActive")
            }
            
             UserDefault.bonusLevelNumber = level + 1
            
        case 3:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 3)
            buttonsDisableInteractonExcept(indexActive: 3)
            
            let buttons = levelButtons.enumerated()
            let crosses = levelCrosses.enumerated()
            
            for (_, value) in buttons where value.tag == 1 {
            value.setImage(UIImage(named: "treasure1000blured"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 2 {
            value.setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 3 {
            value.setImage(UIImage(named: "treasure2500"), for: .normal)
            }
            
            for (_, value) in crosses where value.tag == 1 {
            value.image = UIImage(named: "crossActive")
            }
            
            for (_, value) in crosses where value.tag == 2 {
            value.image = UIImage(named: "crossActiveRight")
            }
            
            UserDefault.bonusLevelNumber = level + 1
            
        case 4:
            
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 4)
            buttonsDisableInteractonExcept(indexActive: 4)
            
            let buttons = levelButtons.enumerated()
            let crosses = levelCrosses.enumerated()
            
            for (_, value) in buttons where value.tag == 1 {
            value.setImage(UIImage(named: "treasure1000blured"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 2 {
            value.setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 3 {
            value.setImage(UIImage(named: "treasure2500blured"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 4 {
            value.setImage(UIImage(named: "tryYourLuckActiveLeft"), for: .normal)
            }
            
            for (_, value) in crosses where value.tag == 1 {
            value.image = UIImage(named: "crossActive")
            }
            
            for (_, value) in crosses where value.tag == 2 {
            value.image = UIImage(named: "crossActiveRight")
            }
            
            for (_, value) in crosses where value.tag == 3 {
            value.image = UIImage(named: "crossActive")
            }
            
            UserDefault.bonusLevelNumber = level + 1
            
        case 5:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 5)
            buttonsDisableInteractonExcept(indexActive: 5)
            
            let buttons = levelButtons.enumerated()
            let crosses = levelCrosses.enumerated()
            
            for (_, value) in buttons where value.tag == 1 {
            value.setImage(UIImage(named: "treasure1000blured"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 2 {
            value.setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 3 {
            value.setImage(UIImage(named: "treasure2500blured"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 4 {
            value.setImage(UIImage(named: "tryYourLuckPassiveLeft"), for: .normal)
            }
            
            for (_, value) in buttons where value.tag == 5 {
            value.setImage(UIImage(named: "treasure5000"), for: .normal)
            }
            
            
            for (_, value) in crosses where value.tag == 1 {
            value.image = UIImage(named: "crossActive")
            }
            
            for (_, value) in crosses where value.tag == 2 {
            value.image = UIImage(named: "crossActiveRight")
            }
            
            for (_, value) in crosses where value.tag == 3 {
            value.image = UIImage(named: "crossActive")
            }
            
            for (_, value) in crosses where value.tag == 4 {
            value.image = UIImage(named: "crossActiveLeft")
            }
            
            UserDefault.bonusLevelNumber = level + 1
            
        default:
        
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 1)
            buttonsDisableInteractonExcept(indexActive: 1)
            
            UserDefault.bonusLevelNumber = 1
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    @IBAction func firstLevelBonusButton(_ sender: UIButton) {
                
        let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
        vc.gotItActionDismissState = false
        vc.update1000Coins()
        
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        UserDefault.totalCoins += 1_000
        UserDefault.coinsEarned += 1_000
        
        present(vc, animated: true)
    }
    
    @IBAction func secondLevelBonusButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)
    }
    
    @IBAction func thirdLevelBonusButton(_ sender: UIButton) {
                
        let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
        vc.gotItActionDismissState = false
        vc.update2500Coins()
        
        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        UserDefault.totalCoins += 2_500
        UserDefault.coinsEarned += 2_500
        
        present(vc, animated: true)
    }
    
    @IBAction func forthLevelBonusButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)
    }
    
    @IBAction func fifthLevelBonusButton(_ sender: UIButton) {
                
        let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
        vc.gotItActionDismissState = false
        vc.update5000Coins()

        if let presented = self.presentedViewController {
            presented.removeFromParent()
        }
        
        UserDefault.totalCoins += 5_000
        UserDefault.coinsEarned += 5_000
        
        present(vc, animated: true)
    }
}
