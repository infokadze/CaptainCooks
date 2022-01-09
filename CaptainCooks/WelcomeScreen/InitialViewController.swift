//
//  ViewController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 04.01.2022.
//

import UIKit


class InitialViewController: UIViewController {
    
    @IBOutlet var mainVCLevelButtons: [UIButton]!
    
    @IBAction func goToMatchGame(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToMatchGameBoard", sender: sender)
    }
    
    @IBAction func goToBonusMap(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToBonusMap", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToMatchGameBoard" {
            guard segue.destination is MatchGameViewController else { return }
            
            _ = SoundManager.sharedInstance.audioPlayer!.fadeVolume(from: 1, to: 0, duration: 5, completion: nil)
        }
        
        else if segue.identifier == "goToBonusMap" {
            guard segue.destination is BonusMapController else { return }

        }
    }
    
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainVCLevelButtons.forEach {
            
            mainVCLevelButtons[0].tag = 1
            if $0.tag == 1 { $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5, speed: 1.5), forKey: "iconShakeAnimation")
            } else {
                $0.layer.add(createIconShakeAnimation(fromValue: -0.5, toValue: 0.5), forKey: "iconShakeAnimation")
            }
            
            setupBackgroundAudio(playerClassInstance: SoundManager.sharedInstance, sound: .main)
        }
    }
}





