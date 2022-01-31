//
//  NotEnoughCoinsVC.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 06.01.2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    
    
    @IBAction func gotItAction(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        dismiss(animated: true) {
            
            if let presented = self.presentedViewController {
                    presented.removeFromParent()
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelOnTheSameLevel), name: Notification.Name(rawValue: "updateLabelOnTheSameLevel") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelAlreadyPassedLevel), name: Notification.Name(rawValue: "updateLabelAlreadyPassedLevel") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelNotEnoughCoinsLevel), name: Notification.Name(rawValue: "updateLabelNotEnoughCoinsLevel") , object: nil)
    }
    
    @objc func updateLabelOnTheSameLevel() {

        labelText.text = """
        You are already located on this point of the map! Keep spinning to achieve new level!
        """
    }
    
    @objc func updateLabelAlreadyPassedLevel() {

        labelText.text = """
        You already passed this level! You are able to earn more coins on your current location!
        """
    }
    
    @objc func updateLabelNotEnoughCoinsLevel() {

        labelText.text = """
        To play this location you need to earn \(abs(InitialViewController.difference!).formattedWithSeparator) coins. Try again when you've got enough coins!
        """
    }
    
    //MARK: - NotificationCentersForSlots
    
    @objc func updateToFirstLevel() {
        DispatchQueue.main.async {
            self.labelText.text = """
        You are playing on the first level! Check your bonus tomorrow if you need some extra coins boost!
        """
        }
    }
    
    @objc func updateToSecondLevel() {
        DispatchQueue.main.async {
            self.labelText.text = """
                    You are playing on the second level! Check your bonus tomorrow if you need some extra coins boost!
                    """
        }
        
    }
    
    @objc func updateToThirdLevel() {
        DispatchQueue.main.async {
            self.labelText.text = """
                You are playing on the third level! Check your bonus tomorrow if you need some extra coins boost!
                """
        }
    }
    
    @objc func updateToForthLevel() {
        DispatchQueue.main.async {
            self.labelText.text = """
                You are playing on the forth level! Check your bonus tomorrow if you need some extra coins boost!
                """
        }
    }
    
    @objc func updateToFifthLevel() {
        DispatchQueue.main.async {
            self.labelText.text = """
                You are playing on the fifth final level! Check your bonus tomorrow if you need some extra coins boost!
                """
        }
    }
}
