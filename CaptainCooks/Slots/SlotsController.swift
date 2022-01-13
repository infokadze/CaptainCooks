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
    
    @IBAction func testButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! InitialViewController
        present(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
