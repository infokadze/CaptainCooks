//
//  PreloaderVC.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 13.01.2022.
//

import UIKit

class PreloaderVC: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel! {
        didSet {
            mainLabel.textAlignment = .center
            _ = makeLabelChewyColor(label: mainLabel, text: "Captain Cooks", size: 41)
            mainLabel.doGlowAnimation(withColor: .yellow, withEffect: .big)
        }
    }
    
    @IBOutlet weak var progressBar: UIProgressView! {
        didSet {
            progressBar.layer.cornerRadius = 8
            progressBar.layer.masksToBounds = true
            progressBar.trackTintColor = .black
            progressBar.setProgress(0.0, animated: false)
            progressBar.progressViewStyle = .bar
            progressBar.progressTintColor = .yellow
            //important layout setting
            progressBar.layoutIfNeeded()
            
        }
    }
    
    private func startProgress(_ progressView: UIProgressView) {
        if progressView.progress != 1 {
            UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut) {
                progressView.setProgress(1.0, animated: true)
            } completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
                    self.performSegue(withIdentifier: Key.segueID.fromPreloader, sender: self)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startProgress(progressBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let maskLayerPath = UIBezierPath(roundedRect: progressBar.bounds, cornerRadius: 8.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = progressBar.bounds
        maskLayer.path = maskLayerPath.cgPath
        progressBar.layer.mask = maskLayer
        progressBar.startShimmeringAnimation(animationSpeed: 4, direction: .leftToRight, repeatCount: 1)
    }
}

    
    
    

