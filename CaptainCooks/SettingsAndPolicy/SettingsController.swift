//
//  SettingsController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 06.01.2022.
//

import UIKit
import AVFoundation

class SettingsController: UIViewController {
    
    var mainVCSettingsButtonState: Bool?

    @IBOutlet weak var soundAndPrivacyLabel: UILabel!
    @IBOutlet weak var musicAndTermsLabel: UILabel!
    
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSettingButtons()
        
        switch mainVCSettingsButtonState {
        case true:
            _ = makeLabelChewyColor(label: soundAndPrivacyLabel, text: "Sound", size: 35, color: Constants.purpleColor)
            _ = makeLabelChewyColor(label: musicAndTermsLabel, text: "Music", size: 35, color: Constants.purpleColor)
            
            privacyButton.isHidden = true
            termsButton.isHidden = true
            
        case false:
            _ = makeLabelChewyColor(label: soundAndPrivacyLabel, text: "Privacy Policy", size: 35, color: Constants.purpleColor)
            _ = makeLabelChewyColor(label: musicAndTermsLabel, text: "Terms of Use", size: 35, color: Constants.purpleColor)
            _ =  makeSettingsButtonImage(button: privacyButton, image: UIImage(named: "chevronRight")!, needsRendering: true)
            _ =  makeSettingsButtonImage(button: termsButton, image: UIImage(named: "chevronRight")!, needsRendering: true)
            
            musicButton.isHidden = true
            soundButton.isHidden = true
            
        default:
            break
        }
    }
      
    @IBAction func soundButtonTapped(_ sender: UIButton) {
        sender.blink()

        switch UserDefault.isSoundOn {
        
        case true:
            sender.setImage(UIImage(named: "buttonOff"), for: .normal)
            UserDefault.isSoundOn = false
        
        case false:
            sender.setImage(UIImage(named: "buttonOn"), for: .normal)
            UserDefault.isSoundOn = true
            playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        }
    }
    
    @IBAction func musicButtonTapped(_ sender: UIButton) {
        sender.blink()
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)

        
        switch UserDefault.isBackgroundMusicOn {
        case true:
            sender.setImage(UIImage(named: "buttonOff"), for: .normal)
            UserDefault.isBackgroundMusicOn = false
            stopBackgroundAudio(playerClassInstance: .sharedAudioBackgroundObject, sound: .main)
            
        case false:
            sender.setImage(UIImage(named: "buttonOn"), for: .normal)
            UserDefault.isBackgroundMusicOn = true
            playBackgroundAudio(playerClassInstance: .sharedAudioBackgroundObject, sound: .main)
            playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        }
    }
    
    @IBAction func termsOrPolicyVC(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        performSegue(withIdentifier: Constants.segueID.privacyAndTermsVC, sender: sender)
    }
    
    private func setupSettingButtons() {
        UserDefault.isSoundOn ? soundButton.setImage(UIImage(named: "buttonOn"), for: .normal): soundButton.setImage(UIImage(named: "buttonOff"), for: .normal)
        
        UserDefault.isBackgroundMusicOn ? musicButton.setImage(UIImage(named: "buttonOn"), for: .normal): musicButton.setImage(UIImage(named: "buttonOff"), for: .normal)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.segueID.privacyAndTermsVC && (sender as? UIButton) == privacyButton {
            if let vc = segue.destination as? PrivacyPolicyAndTermsVC {
                vc.privacyPolicyTapped = true
            }
        }
        
        else if  segue.identifier == Constants.segueID.privacyAndTermsVC && (sender as? UIButton) == termsButton {
            if let vc = segue.destination as? PrivacyPolicyAndTermsVC {
                vc.privacyPolicyTapped = false
            }
        }
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dismiss(animated: true)

        }
    }
    
   
}

