//
//  PrivacyPolicyAndTermsVC.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 11.01.2022.
//

import UIKit


class PrivacyPolicyAndTermsVC: UIViewController {
    
    var privacyPolicyTapped: Bool?
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            _ =  makeSettingsButtonImage(button: backButton, image: UIImage(named: "buttonBackfromSettings")!, needsRendering: false)
        }
    }
    
    @IBOutlet weak var privacyLabel: UILabel!

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textAlignment = .justified
            textView.layer.cornerRadius = 8
            textView.backgroundColor = UIColor.rgbColor(red: 81, green: 36, blue: 3, alpha: 1)
            textView.isEditable = false
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.dismiss(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch privacyPolicyTapped {
        
        case true:
            _ = makeLabelChewyColor(label: privacyLabel, text: "Privacy Policy", size: 41, color: Constants.purpleColor)
            _ = makeChewyTextView(textView: textView, text: Constants.Text.privacyPolicyText, size: 22)

        case false:
            _ = makeLabelChewyColor(label: privacyLabel, text: "Terms of Use", size: 41, color: Constants.purpleColor)
            _ = makeChewyTextView(textView: textView, text: Constants.Text.termsOfUseText, size: 22)

        
        default:
            break
        }
    }
}
