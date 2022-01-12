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
            _ =  makeSettingsButtonImage(button: backButton, image: UIImage(named: "buttonBack")!, needsRendering: false)
        }
    }
    
    @IBOutlet weak var privacyLabel: UILabel!

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textColor = .white
            textView.textAlignment = .justified
            textView.backgroundColor = UIColor.rgbColor(red: 81, green: 36, blue: 3, alpha: 1)
            textView.isEditable = false
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch privacyPolicyTapped {
        
        case true:
            textView.text = K.Text.privacyPolicyText
            _ = makeLabelChewyColor(label: privacyLabel, text: "Privacy Policy", size: 41)

        case false:
            textView.text = K.Text.termsOfUseText
            _ = makeLabelChewyColor(label: privacyLabel, text: "Terms of Use", size: 41)
        
        default:
            break
        }
    }
}
