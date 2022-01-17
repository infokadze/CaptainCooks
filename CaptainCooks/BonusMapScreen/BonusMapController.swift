//
//  BonusMapController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 05.01.2022.
//

import UIKit
import CoreMedia

final class BonusMapController: UIViewController {

    var particle1 = CAEmitterCell()
    var particle2 = CAEmitterCell()
    var particle3 = CAEmitterCell()

    @IBOutlet weak var bonusMapBackground: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var levelButtons: [UIButton]!
    @IBOutlet var levelCrosses: [UIImageView]!
    
    
    //MARK: - Button Actions
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        present(vc, animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createParticles()
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
    
    private func buttonsDisableInteractonExcept(indexActive: Int) {
        let buttons = levelButtons.enumerated()
        for (index, value) in buttons where index != indexActive {
            value.isEnabled = false
        }
    }
    
    private func filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: Int) {
    
        let buttons = levelButtons.enumerated()
        for (index, value) in buttons where index != buttonAndCrossIndexExclusion {
            value.layer.add(createIconShakeAnimation(fromValue: 0.0, toValue: 0.05), forKey: "iconShakeAnimation") }
            
        
        let crosses = levelCrosses.enumerated()
        for (index, value) in crosses where index != buttonAndCrossIndexExclusion {
            value.layer.add(createIconShakeAnimation(fromValue: 0.0, toValue: 0.05), forKey: "iconShakeAnimation")
            
            
            let activeLevel = levelButtons[buttonAndCrossIndexExclusion]
            activeLevel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .big)
    }
}
    
    private func restartApplication () {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.preloader) as! PreloaderVC
        UserDefault.bonusLevelNumber = 1
        present(vc, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        switch UserDefault.bonusLevelNumber {
        case 1:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 0)
            buttonsDisableInteractonExcept(indexActive: 0)
        case 2:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 1)
            buttonsDisableInteractonExcept(indexActive: 1)
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckActiveRight"), for: .normal)
            
            levelCrosses[0].image = UIImage(named: "crossActive")
        case 3:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 2)
            buttonsDisableInteractonExcept(indexActive: 2)
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            levelButtons[2].setImage(UIImage(named: "treasure2500"), for: .normal)
            
            levelCrosses[0].image = UIImage(named: "crossActive")
            levelCrosses[1].image = UIImage(named: "crossActiveRight")
            
        case 4:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 3)
            buttonsDisableInteractonExcept(indexActive: 3)
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            levelButtons[2].setImage(UIImage(named: "treasure2500blured"), for: .normal)
            levelButtons[3].setImage(UIImage(named: "tryYourLuckActiveLeft"), for: .normal)
            
            levelCrosses[0].image = UIImage(named: "crossActive")
            levelCrosses[1].image = UIImage(named: "crossActiveRight")
            levelCrosses[2].image = UIImage(named: "crossActive")
            
        case 5:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 4)
            buttonsDisableInteractonExcept(indexActive: 4)
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            levelButtons[2].setImage(UIImage(named: "treasure2500blured"), for: .normal)
            levelButtons[3].setImage(UIImage(named: "tryYourLuckPassiveLeft"), for: .normal)
            levelButtons[4].setImage(UIImage(named: "treasure5000"), for: .normal)
            
            levelCrosses[0].image = UIImage(named: "crossActive")
            levelCrosses[1].image = UIImage(named: "crossActiveRight")
            levelCrosses[2].image = UIImage(named: "crossActive")
            levelCrosses[3].image = UIImage(named: "crossActiveLeft")
            
        default:
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            levelButtons[2].setImage(UIImage(named: "treasure2500blured"), for: .normal)
            levelButtons[3].setImage(UIImage(named: "tryYourLuckPassiveLeft"), for: .normal)
            
            
            let alert = UIAlertController(title: "You have received all the bonuses available!", message: "You can reset in order to get more coins each day", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
                self.restartApplication()
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action -> Void in
                self.dismiss(animated: true) })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil) }
    }
    
    @IBAction func firstLevelBonusButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)
        
    }
    
    
    @IBAction func secondLevelBonusButton(_ sender: UIButton) {

        
        performSegue(withIdentifier: Constants.segueID.notEnoughCoinsVC, sender: sender)
    }
    
    @IBAction func thirdLevelBonusButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)

    }
    
    @IBAction func forthLevelBonusButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)

    }
    
    @IBAction func fifthLevelBonusButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)

    }
    

    
}






