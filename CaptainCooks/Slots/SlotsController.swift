//
//  SlotsController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 13.01.2022.
//

import UIKit

class SlotsController : UIViewController {
    
    @IBOutlet weak var slotsImage: UIImageView! {
        didSet {
            slotsImage.image = UIImage(named: "screenSlot1")
        }
    }
    
    @IBOutlet weak var wheelImageView: UIImageView! {
        didSet {
            wheelImageView.image = UIImage(named: "pngegg")
        }
    }
    
    @IBOutlet weak var spinImageView: UIImageView! {
        didSet {
            spinImageView.image = UIImage(named: "spin")
        }
    }
    
    @IBAction func testButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Constants.storyboardName.mainName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.storyboardID.main) as! InitialViewController
        present(vc, animated: true)
        
    }
    
//    #warning("set to the button on main screen")
//    if indexPath.item == 0 {
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SlotViewController") as! SlotViewController
//        controller.slotsElements = slotsElementsPack2
//        self.navigationController?.pushViewController(controller, animated: true)
//    } else if indexPath.item == 1 {
////            if Level.shared.level >= 2 {
//            let controller = self.storyboard?.instantiateViewController(withIdentifier: "SlotViewController") as! SlotViewController
//            controller.slotsElements = slotsElementsPack1
//            self.navigationController?.pushViewController(controller, animated: true)
////            }
//    } else if indexPath.item == 2 {
//        if Level.shared.coinsPool >= 5000 {
//            UserDefaultsManager.LevelChoose = 2
//            Level.shared.coinsPool = Level.shared.coinsPool - 5000
//        }
//        if UserDefaultsManager.LevelChoose == 2 {
//            let controller = self.storyboard?.instantiateViewController(withIdentifier: "SlotViewController") as! SlotViewController
//            controller.slotsElements = slotsElementsPack2
//            self.navigationController?.pushViewController(controller, animated: true)
//        }
//    } else if indexPath.item == 3 {
//        if Level.shared.coinsPool >= 8000 {
//            UserDefaultsManager.LevelChoose = 2
//            Level.shared.coinsPool = Level.shared.coinsPool - 8000
//        }
//        if UserDefaultsManager.LevelChoose == 2 {
//            let controller = self.storyboard?.instantiateViewController(withIdentifier: "SlotViewController") as! SlotViewController
//            controller.slotsElements = slotsElementsPack1
//            self.navigationController?.pushViewController(controller, animated: true)
//        }
//    } else {
//        return
//    }
//}
//}
//
//    #warning("level to choose -> screen appearance")
//    if UserDefaultsManager.LevelChoose == 0 {
//        for i in 1...4 {
//            imagesArray.append(UIImage(named: "\(i)")!)
//        }
//    }else if UserDefaultsManager.LevelChoose == 2 {
//        imagesArray.removeAll()
//        imagesArray.append(UIImage(named: "\(1)")!)
//        imagesArray.append(UIImage(named: "\(2)")!)
//        imagesArray.append(UIImage(named: "\(5)")!)
//        imagesArray.append(UIImage(named: "\(4)")!)
//    }else if UserDefaultsManager.LevelChoose == 3 {
//        imagesArray.removeAll()
//        imagesArray.append(UIImage(named: "\(1)")!)
//        imagesArray.append(UIImage(named: "\(2)")!)
//        imagesArray.append(UIImage(named: "\(5)")!)
//        imagesArray.append(UIImage(named: "\(6)")!)
//    }
//
//    #warning("+ - buttons")
//    @IBAction func bet25MoreCoins(_ sender: UIButton) {
//        if coinsToBet < 300 {
//            coinsToBet += 25
//            coinsToBetButton.setTitle("\(coinsToBet)", for: .normal)
//        }
//    }
//
//
//    @IBAction func bet25LessCoins(_ sender: UIButton) {
//        if coinsToBet > 25 {
//            coinsToBet -= 25
//            coinsToBetButton.setTitle("\(coinsToBet)", for: .normal)
//        }
//    }
//    #warning("coins to bet")
//    private var coinsToBet = 25
//
//    @IBOutlet weak var coinsToBetButton: UIButton!{
//        didSet {
//            coinsToBetButton.setTitle("\(coinsToBet)", for: .normal)
//        }
//    }
//
//    #warning("coins balance")
//    private var balance = Level.shared.coinsPool {
//        didSet {
//            Level.shared.coinsPool = coinsPool
//            coinsCounterButton.setTitle("\(coinsPool)", for: .normal)
//        }
//    }
//
//    #warning("music button")
//    @IBAction func musicTapped(_ sender: Any) {
////        if ismusicPlaying == false {
////            backgroundPlayer.cheer()
////            ismusicPlaying = true
////        }else {
////            backgroundPlayer.stop()
////            ismusicPlaying = false
////        }
//        if Level.shared.musicOn == false {
//            backgroundPlayer.cheer()
//            Level.shared.musicOn = true
//        }else {
//            backgroundPlayer.stop()
//            Level.shared.musicOn = false
//        }
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        wheelImageView.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
                
    }
    
    @IBAction func spinAction(_ sender: UIButton) {

        wheelImageView.startRotating()
        
    }
    
}

extension UIView {
    func startRotating(duration: Double = 0.5, randomRotationPath: Bool = Bool.random()) {

        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.autoreverses = true
            animate.repeatCount = 0
            
            animate.speed = 1
            animate.fromValue = 0
            
            if randomRotationPath {
            animate.toValue = 1
            } else {
                animate.toValue = -1
            }
            self.layer.add(animate, forKey: kAnimationKey)
            
        }
    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
         
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}


