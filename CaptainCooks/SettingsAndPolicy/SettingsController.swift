//
//  SettingsController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 06.01.2022.
//

import UIKit

class SettingsController: UIViewController {
    
    var mainVCSettingsButtonState: Bool?

    @IBOutlet weak var soundAndPrivacyLabel: UILabel!
    @IBOutlet weak var musicAndTermsLabel: UILabel!
    
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var termsButton: UIButton!
      
    @IBAction func soundButtonTapped(_ sender: UIButton) {
        sender.blink()
        
        switch sender.currentImage {
        case UIImage(named: "buttonOn"):
            sender.setImage(UIImage(named: "buttonOff"), for: .normal)
            UserDefault.isMutedSound = true
            
        case UIImage(named: "buttonOff"):
            sender.setImage(UIImage(named: "buttonOn"), for: .normal)
            UserDefault.isMutedSound = false

        default:
            break
        }
    }
    
    @IBAction func termsOrPolicyVC(_ sender: UIButton) {
        performSegue(withIdentifier: Key.segueID.privacyAndTerms, sender: sender)
    }
    
    @IBAction func musicButtonTapped(_ sender: UIButton) {
        sender.blink()
        switch sender.currentImage {
            
        case UIImage(named: "buttonOn"):
            sender.setImage(UIImage(named: "buttonOff"), for: .normal)
            UserDefault.isMutedBackgroundMusic = true

        case UIImage(named: "buttonOff"):
            sender.setImage(UIImage(named: "buttonOn"), for: .normal)
            UserDefault.isMutedBackgroundMusic = false

        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Key.segueID.privacyAndTerms && (sender as? UIButton) == privacyButton {
            if let vc = segue.destination as? PrivacyPolicyAndTermsVC {
                vc.privacyPolicyTapped = true
            }
        }
        
        else if  segue.identifier == Key.segueID.privacyAndTerms && (sender as? UIButton) == termsButton {
            if let vc = segue.destination as? PrivacyPolicyAndTermsVC {
                vc.privacyPolicyTapped = false
            }
        }
    }

    @IBAction func dismissAction(_ sender: UIButton) {            self.dismiss(animated: true) {
                self.presentingViewController?.dismiss(animated: false)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        switch mainVCSettingsButtonState {
        case true:
            _ = makeLabelChewyColor(label: soundAndPrivacyLabel, text: "Sound", size: 41)
            _ = makeLabelChewyColor(label: musicAndTermsLabel, text: "Music", size: 41)
            _ =  makeSettingsButtonImage(button: soundButton, image: UIImage(named: "buttonOn")!, needsRendering: false)
            _ =  makeSettingsButtonImage(button: musicButton, image: UIImage(named: "buttonOff")!, needsRendering: false)
            
            privacyButton.isHidden = true
            termsButton.isHidden = true
            
        case false:
            _ = makeLabelChewyColor(label: soundAndPrivacyLabel, text: "Privacy Policy", size: 30)
            _ = makeLabelChewyColor(label: musicAndTermsLabel, text: "Terms of Use", size: 30)
            _ =  makeSettingsButtonImage(button: privacyButton, image: UIImage(named: "chevronRight")!, needsRendering: true)
            _ =  makeSettingsButtonImage(button: termsButton, image: UIImage(named: "chevronRight")!, needsRendering: true)
            
            musicButton.isHidden = true
            soundButton.isHidden = true
            
        default:
            break
        }
    }
}

