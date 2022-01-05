//
//  ViewController.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 04.01.2022.
//

import UIKit

class InitialViewController: UIViewController {

    @IBAction func segueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMatchGame", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMatchGame" {
            guard segue.destination is MatchGameViewController else { return }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
