//
//  ViewController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 04.01.2022.
//

import UIKit

class InitialViewController: UIViewController {
    
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
            _ = makeLabelChewyColor(label: levelNumberLabel, text: "\(UserDefault.mainLevelNumber)", size: 21)

    }
}
    
    @IBOutlet weak var treasureImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!

    @IBOutlet weak var getYourBonusView: UIView!
    
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
            _ = makeLabelChewyColor(label: levelLabel, text: "Level", size: 20)
        }
    }
    
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: balanceLabel, text: "Balance", size: 20)
        }
    }

    @IBOutlet weak var getYourBonusButton: UIButton! {
        didSet {
            getYourBonusButton.startShimmeringAnimation(animationSpeed: 3, direction: .leftToRight, repeatCount: .infinity)
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.textColor = Constants.goldColor
            amountLabel.text = "\(UserDefault.coins.formattedWithSeparator)"
            amountLabel.doGlowAnimation(withColor: Constants.goldColor, withEffect: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getYourBonusView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        checkIfBonusScreenAvailable()
//        checkLevel()
//        checkCoins()
        
        mainVCLevelButtons.forEach {
                $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5, speed: 0.8), forKey: "iconShakeAnimation")
            }
    
        treasureImageView.doGlowAnimation(withColor: Constants.goldColor, withEffect: .big)
        
    }

    
    private func setMapLocksAndSkullExceptCurrent(indexException: Int) {
        let buttons = mainVCLevelButtons.sorted { $0.tag < $1.tag }.enumerated()
        
        for (index, value) in buttons where index != indexException {
            value.setImage(UIImage(named: "closedLevelLock"), for: .normal)
        
            let activeLevel = mainVCLevelButtons[indexException]
            activeLevel.setImage(UIImage(named: "skullOnMap"), for: .normal)
        
        }
        
    }
        
    @IBAction func gotItAction(_ sender: UIButton) {

        performSegue(withIdentifier: Constants.segueID.bonusMapVC, sender: sender)
//        performSegue(withIdentifier: Constants.segueID.slotsVC, sender: sender)
    }
    
    @IBAction func settingsOrInfoButtonTapped(_ sender: UIButton) {
                performSegue(withIdentifier: Constants.segueID.settingsOrInfoVC, sender: sender)
    }
    
    @IBAction func getYourBonusButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.segueID.bonusMapVC, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == Constants.segueID.bonusGameVC {
            guard segue.destination is MatchGameViewController else { return }
        }
        
        else if segue.identifier == Constants.segueID.bonusMapVC {
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
    
    #warning("update coins func + not enough coins")
    func checkCoins() {
        switch UserDefault.coins {
        case 10_000..<12_000:
            print("level 1")
                //change progress image + level number
        case 12_000..<14_000:
            print("level 2")
            //change progress image + level number
        case 14_000..<16_000:
            print("level 3")
            //change progress image + level number
        case 16_000..<18_000:
            print("level 4")
            //change progress image + level number
        case 18_000..<20_000:
            print("level 5")
            //change progress image + level number
        default: break
        }
    }
    
    #warning("update level")
    func checkLevel() {
        
        switch UserDefault.mainLevelNumber {
        case 10_000..<12_000:
            print("level 1")
                //change progress image + level number
        case 12_000..<14_000:
            print("level 2")
            //change progress image + level number
        case 14_000..<16_000:
            print("level 3")
            //change progress image + level number
        case 16_000..<18_000:
            print("level 4")
            //change progress image + level number
        case 18_000..<20_000:
            print("level 5")
            //change progress image + level number
        default: break
        }
    }
    
#warning("update checkDate to present bonuses")
    func checkIfBonusScreenAvailable() {
        if let date = UserDefault.currentDate as? Date {
            if let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff > 24 {
                getYourBonusView.isHidden = false
                mainAdviceScreen.isHidden = true
                
            } else {
                getYourBonusView.isHidden = true
                mainAdviceScreen.isHidden = false
            }
        }
    }
    
    
    
}





