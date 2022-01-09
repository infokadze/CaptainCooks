//
//  NotEnoughCoinsVC.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 06.01.2022.
//

import UIKit

class NotEnoughCoinsVC: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBAction func gotItAction(_ sender: UIButton) {
        dismiss(animated: true) {
            
            _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 0, to: 1, duration: 2, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelText.text = """
To play this location you need to earn 1500 coins. Try again when you've got enough coins
"""
    }
}
