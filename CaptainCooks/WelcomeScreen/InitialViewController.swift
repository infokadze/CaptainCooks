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
    
    @IBOutlet var mainVCLevelButtons: [UIButton]!
    
    @IBOutlet weak var levelLabel: UILabel! {
        didSet {
            _ = makeLabelChewyColor(label: levelLabel, text: "Level 1", size: 20)
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
            amountLabel.doGlowAnimation(withColor: .yellow, withEffect: .normal)
        }
    }
    
    @IBAction func settingsOrInfoButtonTapped(_ sender: UIButton) {
        
        sender.blink()
        performSegue(withIdentifier: "goToSettingsOrInfo", sender: sender)
    }
    
    @IBAction func getYourBonusButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMatchGameBoard", sender: sender)
    }
    
    @IBAction func goToBonusMap(_ sender: UIButton) {
        performSegue(withIdentifier: "goToBonusMap", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "goToMatchGameBoard" {
            guard segue.destination is MatchGameViewController else { return }
            
            _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 5, completion: nil)
        }
        
        else if segue.identifier == "goToBonusMap" {
            guard segue.destination is BonusMapController else { return }
        }
        
        else if segue.identifier == "goToSettingsOrInfo" && sender as? NSObject == settingsButton {
            guard segue.destination is SettingsController else { return }
            if let vc = segue.destination as? SettingsController {
                vc.mainVCSettingsButtonState = true

            }
            
        }  else if  segue.identifier == "goToSettingsOrInfo" && sender as? NSObject == infoButton {
            if let vc = segue.destination as? SettingsController {
                vc.mainVCSettingsButtonState = false

            }
        }
    }
    
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundAudio(playerClassInstance: SoundManager.sharedInstance, sound: .main)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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





