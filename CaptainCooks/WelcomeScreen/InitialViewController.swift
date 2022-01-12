//
//  ViewController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 04.01.2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var progressImageView: UIImageView!
    @IBOutlet weak var treasureImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var getYourBonusView: UIView!
    
    @IBOutlet var mainVCLevelButtons: [UIButton]!
    
    @IBOutlet weak var levelLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: levelLabel, text: "Level", size: 20)
        }
    }
    
    @IBOutlet weak var levelNumberLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: levelNumberLabel, text: "1", size: 31)
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
            amountLabel.textColor = .yellow
            amountLabel.text = "\(UserDefault.coins.formattedWithSeparator)"
            amountLabel.doGlowAnimation(withColor: .yellow, withEffect: .normal)
        }
    }
    
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
    }
    
    @IBAction func settingsOrInfoButtonTapped(_ sender: UIButton) {
        
        sender.blink()
        performSegue(withIdentifier: K.segueID.settingsOrInfoVC, sender: sender)
    }
    
    @IBAction func getYourBonusButton(_ sender: Any) {
        performSegue(withIdentifier: K.segueID.bonusMapVC, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == K.segueID.bonusGameVC {
            guard segue.destination is MatchGameViewController else { return }
            
//            _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 5, completion: nil)
        }
        
        else if segue.identifier == K.segueID.bonusMapVC {
            guard segue.destination is BonusMapController else { return }
        }
        
        else if segue.identifier == K.segueID.settingsOrInfoVC && sender as? NSObject == settingsButton {
            guard segue.destination is SettingsController else { return }
            if let vc = segue.destination as? SettingsController {
                vc.mainVCSettingsButtonState = true

            }
            
        }  else if  segue.identifier == K.segueID.settingsOrInfoVC && sender as? NSObject == infoButton {
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
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#warning("update checkDate to present bonuses")
        if let date = UserDefault.currentDate as? Date {
            if let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff > 24 {
                //do something
            } else {
                getYourBonusView.isHidden = true
                
            }
        }
        
        setupBackgroundAudio(playerClassInstance: SoundManager.sharedInstance, sound: .main)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLevel()
        checkCoins()
        
        mainVCLevelButtons.forEach {
            
            mainVCLevelButtons[0].tag = 1
            if $0.tag == 1 { $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5, speed: 0.8), forKey: "iconShakeAnimation")
            } else {
                $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5, speed: 0.8), forKey: "iconShakeAnimation")
            }
        }
        
        treasureImageView.doGlowAnimation(withColor: .yellow, withEffect: .big)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}





