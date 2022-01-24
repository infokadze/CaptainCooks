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
                        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        To play this location you need to earn \(abs(InitialViewController.difference!)) coins. Try again when you've got enough coins!
        """
    }
    
}
