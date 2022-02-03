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
        
        loadBonusLevel(level: UserDefault.bonusLevelNumber)

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
             UserDefault.currentDate = Date()
            
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
            UserDefault.currentDate = Date()
            
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
            UserDefault.currentDate = Date()
            
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
            UserDefault.currentDate = Date()
            
        default:
        
            filteredButtonsAndCrossesAnimatingWithGlow(buttonAndCrossIndexExclusion: 1)
            buttonsDisableInteractonExcept(indexActive: 1)
            
            UserDefault.bonusLevelNumber = 1
            UserDefault.currentDate = Date()
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
