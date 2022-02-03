//
//  ViewController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 04.01.2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    static var levelCoinsDifference: Int? = 0
    
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var treasureImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var getYourBonusView: UIView!
    @IBOutlet weak var gotItButton: UIButton!
    @IBOutlet weak var mainAdviceScreen: UIView!
    @IBOutlet weak var getYourBonusButton: UIButton!
    
    private var progressImageLevel: Int? {
        didSet {
            progressImageView.image = UIImage(named: "\(UserDefault.mainLevelNumber)progressBar")
        }
    }
    
    @IBOutlet weak var progressImageView: UIImageView! {
        didSet {
            progressImageView.doGlowAnimation(withColor: Constants.goldColor, withEffect: .small)
        }
    }
    
    private var levelNumber: Int? {
        didSet {
            _ = makeLabelChewyColor(label: levelNumberLabel, text: "\(UserDefault.mainLevelNumber)", size: 24, color: Constants.purpleColor)
            
        }
    }
    
    private var levelPasses: [Bool] = [false, false, false, false] {
        didSet {
            switch UserDefault.mainLevelNumber {
            case 1:
                levelPasses = [false, false, false, false]
            case 2:
                levelPasses = [true, false, false, false]
            case 3:
                levelPasses = [true, true, false, false]
            case 4:
                levelPasses = [true, true, true, false]
            case 5:
                levelPasses = [true, true, true, true]
            default:
                ()
            }
        }
    }
    
    @IBOutlet weak var adviceTextView: UILabel! {
        didSet {
            adviceTextView.text = Constants.Text.mainScreenText.randomElement()
            adviceTextView.font = UIFont(name: "Chewy-Regular", size: 20)
            adviceTextView.textColor = .white
            adviceTextView.textAlignment = .justified
        }
    }
    
    @IBOutlet var mainVCLevelButtons: [UIButton]!
    
    @IBOutlet weak var levelLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: levelLabel, text: "Level", size: 24, color: Constants.purpleColor)
        }
    }
    
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: balanceLabel, text: "Balance", size: 24, color: Constants.purpleColor)
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.textColor = Constants.goldColor
            amountLabel.text = "\(UserDefault.totalCoins.formattedWithSeparator)"
            amountLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfBonusLevelsAreReset()
        checkIfBonusScreenAvailable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkMainLevel()
        
        progressImageLevel = UserDefault.mainLevelNumber
        levelNumber = UserDefault.mainLevelNumber
        
        mainVCLevelButtons.forEach {
            $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5, speed: 0.8), forKey: "iconShakeAnimation")
        }
        
        treasureImageView.doGlowAnimation(withColor: Constants.goldColor, withEffect: .bigger)
        getYourBonusButton.startShimmeringAnimation(animationSpeed: 3, direction: .leftToRight, repeatCount: .infinity)
    }
    
    private func levelButtonsTouchCheck(sender: UIButton) {
        
        for _ in mainVCLevelButtons.sorted(by: { $0.tag < $1.tag }) {
            
            if sender.tag == 1 {
                UserDefault.levelNumberPicked = 1
                performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
            }
            
            else if sender.tag == 2 && levelPasses[0] == true  {
                UserDefault.levelNumberPicked = 2
                performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
                
            }
            
            else if sender.tag == 3 && levelPasses[1] == true {
                UserDefault.levelNumberPicked = 3
                performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
                
            }
            
            else if sender.tag == 4 && levelPasses[2] == true {
                UserDefault.levelNumberPicked = 4
                performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
                
            }
            
            else if sender.tag == 5 && levelPasses[3] == true {
                UserDefault.levelNumberPicked = 5
                performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
                
            }
            
            else if sender.tag > UserDefault.mainLevelNumber {
                
                let currentCoins = UserDefault.coinsEarned
                
                let coinsPoolforLevelReference = [currentCoins, 5_000, 10_000, 15_000, 20_000]
                InitialViewController.levelCoinsDifference = coinsPoolforLevelReference[sender.tag - 1] - currentCoins
                NotificationCenter.default.post(name: Notification.Name(rawValue: "updateLabelNotEnoughCoinsLevel"), object: nil)
                
                let storyBoard = UIStoryboard(name: Constants.storyboardName.bonusName, bundle: Bundle.main)
                let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.popUpID) as! PopUpVC
                
                if let presented = self.presentedViewController {
                    presented.removeFromParent()
                }
                
                present(vc, animated: true)
            }
        }
    }
    
    
    @IBAction func mainVCLevelButtonsActions(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        levelButtonsTouchCheck(sender: sender)
    }
    
    
    @IBAction func gotItAction(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
    }
    
    @IBAction func settingsOrInfoButtonTapped(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        performSegue(withIdentifier: Constants.segueID.settingsOrInfoVC, sender: sender)
    }
    
    @IBAction func getYourBonusButton(_ sender: Any) {
        
        
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
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
        }
        
        else if  segue.identifier == Constants.segueID.settingsOrInfoVC && sender as? NSObject == infoButton {
            if let vc = segue.destination as? SettingsController {
                vc.mainVCSettingsButtonState = false
            }
        }
        
        else if segue.identifier == Constants.segueID.slotsVC && sender as? UIButton == gotItButton {
            guard segue.destination is  SlotsController else { return }
            
            UserDefault.levelNumberPicked = UserDefault.mainLevelNumber
        }
    }
    
    
    private func checkMainLevel() {
        switch UserDefault.coinsEarned {
            
        case 0..<5_000:
            UserDefault.mainLevelNumber = 1
            setDefaultMapIcons(indexException: 0)
            
        case 5_000..<10_000:
            UserDefault.mainLevelNumber = 2
            levelPasses[0] = true
            
            for (_, value) in mainVCLevelButtons.enumerated() {
                if value.tag == 1 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 2 {
                    value.setImage(UIImage(named: "skullOnMap"), for: .normal)
                    value.doGlowAnimation(withColor: Constants.purpleColor, withEffect: .normal, duration: 1)
                }
            }
            
        case 10_000..<15_000:
            UserDefault.mainLevelNumber = 3
            levelPasses[1] = true
            
            for (_, value) in mainVCLevelButtons.enumerated() {
                if value.tag == 1 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 2 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 3 {
                    value.setImage(UIImage(named: "skullOnMap"), for: .normal)
                    value.doGlowAnimation(withColor: Constants.purpleColor, withEffect: .normal, duration: 1)
                }
            }
            
        case 15_000..<20_000:
            UserDefault.mainLevelNumber = 4
            levelPasses[2] = true
            
            for (_, value) in mainVCLevelButtons.enumerated() {
                if value.tag == 1 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 2 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 3 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 4 {
                    value.setImage(UIImage(named: "skullOnMap"), for: .normal)
                    value.doGlowAnimation(withColor: Constants.purpleColor, withEffect: .normal, duration: 1)
                }
            }
            
        case 20_000...:
            UserDefault.mainLevelNumber = 5
            levelPasses[3] = true
            
            for (_, value) in mainVCLevelButtons.enumerated() {
                if value.tag == 1 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 2 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 3 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                } else if value.tag == 4 {
                    value.setImage(UIImage(named: "openedLevelLock"), for: .normal)
                }
                else if value.tag == 5 {
                    value.setImage(UIImage(named: "skullOnMap"), for: .normal)
                    value.doGlowAnimation(withColor: .systemYellow, withEffect: .big, duration: 1)
                }
            }
            
        default:
            ()
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

    private func checkIfBonusLevelsAreReset() {
        if let date = UserDefault.currentDate as? Date {
            if let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff > 48 {
                UserDefault.bonusLevelNumber = 0
            }
        }
    }
  
    
    private func setDefaultMapIcons(indexException: Int) {
        let buttons = mainVCLevelButtons.sorted { $0.tag < $1.tag }.enumerated()
        for (index, value) in buttons where index != indexException {
            value.setImage(UIImage(named: "closedLevelLock"), for: .normal)
        }
        let activeLevel = mainVCLevelButtons[indexException]
        activeLevel.setImage(UIImage(named: "skullOnMap"), for: .normal)
        activeLevel.doGlowAnimation(withColor: Constants.purpleColor, withEffect: .normal, duration: 1)
    }
}
