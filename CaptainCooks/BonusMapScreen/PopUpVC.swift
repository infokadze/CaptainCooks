//
//  NotEnoughCoinsVC.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 06.01.2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!

    var gotItActionDismissState: Bool = true
    
    @IBAction func gotItAction(_ sender: UIButton) {
        playSoundOneTimer(playerClassInstance: .sharedAudioOneTimerObject, sound: .click)
        
        switch gotItActionDismissState {
            
        case true:
            
            dismiss(animated: true) {
                
                if let presented = self.presentedViewController {
                    presented.removeFromParent()
                }
            }
            
        case false:
            
            gotItActionDismissState = true
            
            let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
            
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            present(vc, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabelNotEnoughCoinsLevel), name: Notification.Name(rawValue: "updateLabelNotEnoughCoinsLevel") , object: nil)
    }
    
    
    // dispatch is fucking important!!! spent few days sorting out why the app wasn't able to load proper text via this funcs
    
    @objc func update1000Coins() {
        DispatchQueue.main.async {
            self.labelText.text = """
        "Congratulations! You have found a secret treasure, which allowed you to gain extra 1000 coins to your balance!
        """
    }
}

    @objc func update2500Coins() {
        DispatchQueue.main.async {
            self.labelText.text = """
        It has been your lucky day since you have found a secret treasure, which allowed you to gain additional 2500 coins! Let's spin the lucky slots, shall we?
        """
    }
}
    
    @objc func update5000Coins() {
        DispatchQueue.main.async {
            self.labelText.text = """
        It has been the luckiest day since you started to hunt for a treasure! You got additional 5000 coins! Let's try ou luck on a new level, shall we?
        """
    }
}
    
    @objc func updateLabelNotEnoughCoinsLevel() {
        labelText.text = """
        To play this location you need to earn \(abs(InitialViewController.levelCoinsDifference!).formattedWithSeparator) coins. Try again when you've got enough coins!
        """
    }
    
    //MARK: - NotificationCentersForSlots

    @objc func updateToSecondLevel() {
        DispatchQueue.main.async {
            self.gotItActionDismissState = false
            self.labelText.textAlignment = .justified
            self.labelText.text = """
                            You unlocked the second level! Check your bonus tomorrow if you need some extra coins boost!
                    """
        }
    }
    
    @objc func updateToThirdLevel() {
        DispatchQueue.main.async {
            self.gotItActionDismissState = false
            self.labelText.text = """
                        You unlocked the third level! Check your bonus tomorrow if you need some extra coins boost!
                """
        }
    }
    
    @objc func updateToForthLevel() {
        DispatchQueue.main.async {
            self.gotItActionDismissState = false
            self.labelText.text = """
                        You unlocked the forth fifth level! Check your bonus tomorrow if you need some extra coins boost!
                """
        }
    }
    
    @objc func updateToFifthLevel() {
        DispatchQueue.main.async {
            self.gotItActionDismissState = false
            self.labelText.text = """
                        You unlocked the final fifth level! Enjoy various levels for different visual experience!
                """
        }
    }
}
