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
    
    
    //MARK: - Button Actions
    @IBAction func menuButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch UserDefault.bonusLevelNumber {
        case 1:
            loadBonusLevel(level: 1)
        case 2:
            loadBonusLevel(level: 2)
        case 3:
            loadBonusLevel(level: 3)
        case 4:
            loadBonusLevel(level: 4)
        case 5:
            loadBonusLevel(level: 5)
        default:
            loadBonusLevel(level: 1)
        }
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
    
    private func loadBonusLevel(level: Int) {
        switch level {
        case 1:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 0)
            buttonsDisableInteractonExcept(indexActive: 0)
            
            UserDefault.bonusLevelNumber = level + 1
            
        case 2:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 1)
            buttonsDisableInteractonExcept(indexActive: 1)
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckActiveRight"), for: .normal)
            levelCrosses[0].image = UIImage(named: "crossActive")
            
            UserDefault.bonusLevelNumber = level + 1
            
        case 3:
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 2)
            buttonsDisableInteractonExcept(indexActive: 2)
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            levelButtons[2].setImage(UIImage(named: "treasure2500"), for: .normal)
            
            levelCrosses[0].image = UIImage(named: "crossActive")
            levelCrosses[1].image = UIImage(named: "crossActiveRight")
            
            UserDefault.bonusLevelNumber = level + 1
            
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
            
            UserDefault.bonusLevelNumber = level + 1
            
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
            
            UserDefault.bonusLevelNumber = level + 1
            
        default:
            levelButtons[0].setImage(UIImage(named: "treasure1000blured"), for: .normal)
            levelButtons[1].setImage(UIImage(named: "tryYourLuckAPassiveRight"), for: .normal)
            levelButtons[2].setImage(UIImage(named: "treasure2500blured"), for: .normal)
            levelButtons[3].setImage(UIImage(named: "tryYourLuckPassiveLeft"), for: .normal)
            self.restartApplication()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    @IBAction func firstLevelBonusButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Congratulations!", message: "Your have found a secret treasure, which allowed you to gain extra 1000 coins to your balance!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Great", style: .default) { _ in
            let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
            self.present(vc, animated: true)
            
            }
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)

        UserDefault.coins += 1_000
    }
    
    @IBAction func secondLevelBonusButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)
    }
    
    @IBAction func thirdLevelBonusButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Marvelous!", message: "It has been your lucky day since you have found a secret treasure, which allowed you to gain additional 2500 coins! Let's spin the lucky slots, shall we?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "That's right", style: .default) { _ in
            let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
            self.present(vc, animated: true)
            }
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        UserDefault.coins += 2_500
    }
    
    @IBAction func forthLevelBonusButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segueID.bonusGameVC, sender: sender)
    }
    
    @IBAction func fifthLevelBonusButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Gorgeous!", message: "It has been the luckiest day since you started to hunt for a treasure! You got additional 5000 coins! Let's try ou luck on a new level, shall we?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Let's do it!", style: .default) { _ in
            let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
            self.present(vc, animated: true)
            }
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        UserDefault.coins += 5_000
    }
}
