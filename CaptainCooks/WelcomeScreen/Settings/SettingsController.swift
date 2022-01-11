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
    
    @IBOutlet weak var soundOrPrivacyButton: UIButton!
    @IBOutlet weak var musicOrTermsButton: UIButton!
    
    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.presentingViewController?.dismiss(animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 5, completion: nil)
        
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

