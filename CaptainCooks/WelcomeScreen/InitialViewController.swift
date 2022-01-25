//
//  ViewController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 04.01.2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    static var difference: Int? = 0
    
    @IBOutlet weak var progressImageView: UIImageView! {
        didSet {
            switch UserDefault.mainLevelNumber {
            case 1:
                progressImageView.image = UIImage(named: "progressBarOne")
            case 2:
                progressImageView.image = UIImage(named: "progressBarTwo")
            case 3:
                progressImageView.image = UIImage(named: "progressBarThree")
            case 4:
                progressImageView.image = UIImage(named: "progressBarFour")
            case 5:
                progressImageView.image = UIImage(named: "progressBarFive")
            default:
                progressImageView.image = UIImage(named: "progressBarOne")
            }
        }
    }
    
    @IBOutlet weak var levelNumberLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: levelNumberLabel, text: "\(UserDefault.mainLevelNumber)", size: 21, color: Constants.purpleColor)
    }
}
    
    @IBOutlet weak var treasureImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!

    @IBOutlet weak var getYourBonusView: UIView!
    
    @IBOutlet weak var gotItButton: UIButton!
    
    @IBOutlet weak var mainAdviceScreen: UIView!
       
    @IBOutlet weak var adviceTextView: UILabel! {
        didSet {
            adviceTextView.text = Constants.Text.mainScreenText.randomElement()
            adviceTextView.font = UIFont(name: "Chewy-Regular", size: 20)
            adviceTextView.textColor = .white
            adviceTextView.textAlignment = .justified
        }
    }
    
    @IBOutlet var mainVCLevelButtons: [UIButton]! {
        didSet {
            switch UserDefault.mainLevelNumber {
            case 1:
                setMapLocksAndSkullExceptCurrent(indexException: 0)
            case 2:
                setMapLocksAndSkullExceptCurrent(indexException: 1)
            case 3:
                setMapLocksAndSkullExceptCurrent(indexException: 2)
            case 4:
                setMapLocksAndSkullExceptCurrent(indexException: 3)
            default:
                setMapLocksAndSkullExceptCurrent(indexException: 4)
                
            }
        }
    }
    
    @IBOutlet weak var levelLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: levelLabel, text: "Level", size: 20, color: Constants.purpleColor)
        }
    }
    
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: balanceLabel, text: "Balance", size: 20, color: Constants.purpleColor)
        }
    }
    
    @IBOutlet weak var getYourBonusButton: UIButton!
    
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.textColor = Constants.goldColor
            amountLabel.text = "\(UserDefault.coins.formattedWithSeparator)"
            amountLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfBonusScreenAvailable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkMainLevel()
        
        mainVCLevelButtons.forEach {
            $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5, speed: 0.8), forKey: "iconShakeAnimation")
        }
        
        treasureImageView.doGlowAnimation(withColor: Constants.goldColor, withEffect: .bigger)
        getYourBonusButton.startShimmeringAnimation(animationSpeed: 3, direction: .leftToRight, repeatCount: .infinity)
    }
    
    private func levelButtonsTouchCheck(sender: UIButton) {
        
        for _ in mainVCLevelButtons.sorted(by: { $0.tag < $1.tag }) {
            
            if sender.tag == UserDefault.mainLevelNumber {
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "updateLabelOnTheSameLevel"), object: nil)
                
                let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.notEnoughID) as! NotEnoughCoinsVC
                
                if let presented = self.presentedViewController {
                    presented.removeFromParent()
                }
                
                present(vc, animated: true)
                
            } else if UserDefault.mainLevelNumber  > sender.tag {
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "updateLabelAlreadyPassedLevel"), object: nil)
                
                let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.notEnoughID) as! NotEnoughCoinsVC
                
                if let presented = self.presentedViewController {
                        presented.removeFromParent()
                    }
                
                present(vc, animated: true)
                
            } else if sender.tag > UserDefault.mainLevelNumber {

                let currentCoins = UserDefault.coins

                let coinsPoolforLevelReference = [currentCoins, 12_000, 14_000, 16_000, 18_000]
                
                InitialViewController.difference  =  coinsPoolforLevelReference[sender.tag - 1] - currentCoins
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "updateLabelNotEnoughCoinsLevel"), object: nil)
                
                let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.notEnoughID) as! NotEnoughCoinsVC
                
                if let presented = self.presentedViewController {
                        presented.removeFromParent()
                    }
        
                present(vc, animated: true)
            }
        }
    }
    
    @IBAction func mainVCLevelButtonsActions(_ sender: UIButton) {
        levelButtonsTouchCheck(sender: sender)
    }

        
    @IBAction func gotItAction(_ sender: UIButton) {

//        performSegue(withIdentifier: Constants.segueID.bonusMapVC, sender: sender)
        performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
    }
    
    @IBAction func settingsOrInfoButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segueID.settingsOrInfoVC, sender: sender)
    }
    
    @IBAction func getYourBonusButton(_ sender: Any) {
        
        _ = checkIfBonusLevelsAreReset()
        
        performSegue(withIdentifier: Constants.segueID.bonusMapVC, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == Constants.segueID.bonusMapVC {
            guard segue.destination is BonusMapController else { return }

        }

        else if segue.identifier == Constants.segueID.settingsOrInfoVC && sender as? NSObject == settingsButton {
            guard segue.destination is SettingsController else { return }
            if let vc = segue.destination as? SettingsController {
                vc.mainVCSettingsButtonState = true

            }

        }  else if  segue.identifier == Constants.segueID.settingsOrInfoVC && sender as? NSObject == infoButton {
            if let vc = segue.destination as? SettingsController {
                vc.mainVCSettingsButtonState = false

            }
        }
    }
    
    private func setMapLocksAndSkullExceptCurrent(indexException: Int) {
        let buttons = mainVCLevelButtons.sorted { $0.tag < $1.tag }.enumerated()
        
        for (index, value) in buttons where index != indexException {
            value.setImage(UIImage(named: "closedLevelLock"), for: .normal)
            
            let activeLevel = mainVCLevelButtons[indexException]
            activeLevel.setImage(UIImage(named: "skullOnMap"), for: .normal)
            
        }
    }
        
    private func checkMainLevel() {
        switch UserDefault.coins {
        case 0..<12_000:
            UserDefault.mainLevelNumber = 1
        case 12_000..<14_000:
            UserDefault.mainLevelNumber = 2
        case 14_000..<16_000:
            UserDefault.mainLevelNumber = 3
        case 16_000..<18_000:
            UserDefault.mainLevelNumber = 4
        case 18_000..<20_000:
            UserDefault.mainLevelNumber = 5
        default:
            break
        }
    }
    
   private func checkIfBonusScreenAvailable() {
        
        let calendar = Calendar.current
        let dateToCompare = UserDefault.currentDate

        switch calendar.isDateInToday(dateToCompare) {
        case true:
            getYourBonusView.isHidden = true
            mainAdviceScreen.isHidden = false
            gotItButton.isHidden = false
        case false:
            getYourBonusView.isHidden = false
            mainAdviceScreen.isHidden = true
            gotItButton.isHidden = true
            UserDefault.currentDate = Date()
            
        }
    }
    
   private func checkIfBonusLevelsAreReset() -> Bool {
       
        let interval = Date() - UserDefault.currentDate
        
        switch interval.hour! {
            
        case (0..<24):
            return false
    
        case (24...):
            UserDefault.bonusLevelNumber = 1
            return true
            
        default:
            print("checkIfBonusLevelsAreReset is not working properly")
            return false
        }
    }
}
