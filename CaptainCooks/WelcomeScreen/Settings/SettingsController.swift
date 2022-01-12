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
    
    @IBOutlet weak var soundOrPrivacyButton: UIButton! {
        didSet {
            soundOrPrivacyButton.tag = 1
        }
    }
    
    @IBOutlet weak var musicOrTermsButton: UIButton! {
        didSet {
            musicOrTermsButton.tag = 2
        }
    }
    
    @IBAction func soundOrPrivacyButtonTapped(_ sender: UIButton) {
        sender.blink()
        switch sender.currentImage {
        case UIImage(named: "buttonOn"):
            sender.setImage(UIImage(named: "buttonOff"), for: .normal)
            UserDefault.isMutedSound = true
            
        case UIImage(named: "buttonOff"):
            sender.setImage(UIImage(named: "buttonOn"), for: .normal)
            UserDefault.isMutedSound = false

        case UIImage(named: "chevronRight"):
            //go to PrivacyPolicyAndTermsVC
            performSegue(withIdentifier: K.segueID.privacyPolicy, sender: sender)
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.segueID.privacyPolicy {
            guard let tag = (sender as? UIButton)?.tag else { return }
            
            if tag == musicOrTermsButton.tag {
                if let vc = segue.destination as? PrivacyPolicyAndTermsVC {
                    vc.privacyPolicyTapped = false
                }
            }
            
            else if tag == soundOrPrivacyButton.tag {
                if let vc = segue.destination as? PrivacyPolicyAndTermsVC {
                    vc.privacyPolicyTapped = true
                }
            }
        }
    }
    
    @IBAction func musicOrPolicyButtonTapped(_ sender: UIButton) {
        sender.blink()
        switch sender.currentImage {
        case UIImage(named: "buttonOn"):
            sender.setImage(UIImage(named: "buttonOff"), for: .normal)
//            UserDefault.isMutedBackgroundMusic = true

        case UIImage(named: "buttonOff"):
            sender.setImage(UIImage(named: "buttonOn"), for: .normal)
//            UserDefault.isMutedBackgroundMusic = false

        case UIImage(named: "chevronRight"):
            //go to PrivacyPolicyAndTermsVC
            performSegue(withIdentifier: K.segueID.privacyPolicy, sender: sender)
            
            print("")
        default:
            break
        }
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
            self.dismiss(animated: true) {
                self.presentingViewController?.dismiss(animated: false)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 5, completion: nil)
        
        switch mainVCSettingsButtonState {
        case true:
            _ = makeLabelChewyColor(label: soundAndPrivacyLabel, text: "Sound", size: 41)
            _ = makeLabelChewyColor(label: musicAndTermsLabel, text: "Music", size: 41)
            _ =  makeSettingsButtonImage(button: soundOrPrivacyButton, image: UIImage(named: "buttonOn")!, needsRendering: false)
            _ =  makeSettingsButtonImage(button: musicOrTermsButton, image: UIImage(named: "buttonOff")!, needsRendering: false)
            
        case false:
            _ = makeLabelChewyColor(label: soundAndPrivacyLabel, text: "Privacy Policy", size: 30)
            _ = makeLabelChewyColor(label: musicAndTermsLabel, text: "Terms of Use", size: 30)
            _ =  makeSettingsButtonImage(button: soundOrPrivacyButton, image: UIImage(named: "chevronRight")!, needsRendering: true)
            _ =  makeSettingsButtonImage(button: musicOrTermsButton, image: UIImage(named: "chevronRight")!, needsRendering: true)

            
        default:
            break
        }
    }
}

