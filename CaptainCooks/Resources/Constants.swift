//
//  Constants.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 10.01.2022.
//

import UIKit

struct Constants {
    
    struct segueID {
        static let mainVC = "goToMain"
        static let settingsOrInfoVC = "goToSettingsOrInfo"
        static let bonusGameVC = "goToMatchGame"
        static let bonusMapVC = "goToBonusMap"
        static let notEnoughCoinsVC = "goToNotEnoughCoinsVC"
        static let privacyAndTermsVC = "goToPolicyAndTerms"
        static let fromPreloaderVC = "fromPreloader"
        static let slotsVC = "goToSlots"
    }
    
    struct storyboardID {
        static let preloader = "Preloader"
        static let main = "MainVC"
        static let settings = "SettingsController"
        static let privacyPolicy = "PrivacyPolicy"
        static let bonusMap = "BonusMapStoryboard"
        static let matchGame = "MatchingGameBoard"
        static let slots = "SlotsVC"
        static let notEnoughID = "NotEnoughCoinsBoard"
    }
    
    struct storyboardName {
        static let mainName = "Main"
        static let bonusName = "BonusMapStoryboard"
        static let matchName = "MatchGameBoard"
        static let slotsName = "Slots"
    }
    
    struct Text {
        
        static let privacyPolicyText = """

LeadsDoIt takes your privacy seriously. Privacy policy on this page explains how LeadsDoIt treats any personal information that LeadsDoIt collects and receives when you are using the LeadsDoIt website (“Website”) or products. Please read the content below to learn more about our privacy policy and commitment.

Who We are

LeadsDoIt, Ltd. (“We” or “Our” or “Us” or LeadsDoIt) collects and uses your Personal Data in accordance with this privacy policy and in compliance with the applicable data protection laws. This policy provides you with the necessary information regarding your rights and our obligations, and explains how, why and when we process your personal data.

Our Privacy Commitment

LeadsDoIt does not collect nor process any Personal Data that is not provided by our users specifically, voluntarily and consciously. We guarantee that our staff complies with the strictest standards of safety and confidentiality and that processing of said Personal Data is carried out with total respect of international legislations.
"""
        static let termsOfUseText = """
This agreement governs and is applicable for all Trial, Full and Bundle Licenses for LeadsDoIt software developed and distributed by LeadsDoIt Limited.

Software that is installed and used on computers and other devices utilizing Apple or Windows Operating Systems.

PLEASE READ THIS EULA CAREFULLY BEFORE DOWNLOADING, INSTALLING OR USING LEADSDOIT SOFTWARE. BY DOWNLOADING, INSTALLING AND USING THE SOFTWARE, YOU ARE AGREEING TO BE BOUND BY THE TERMS OF THIS EULA. IF YOU DO NOT AGREE TO THE TERMS OF THIS EULA, DO NOT DOWNLOAD, INSTALL AND/OR USE THE SOFTWARE AND, IF PRESENTED WITH THE OPTION TO “AGREE” OR “DISAGREE” TO THE TERMS, CLICK “DISAGREE”.

This EULA (“User License Agreement”, “License Agreement”, “Terms of Use”, “Agreement”, or “Service Agreement”) is a agreement between you (“You”, “Your”) (either an individual or a single entity) and LeadsDoIt, Ltd. (“LeadsDoIt” or “Us”, “We”) for the LeadsDoIt Software.
"""
        
        static let mainScreenText: [String] =
        ["When you see someone putting on his Big Boots, you can be pretty sure that an Adventure is going to happen", "Every man can transform the world from one of monotony and drabness to one of excitement and adventure", "It’s a dangerous business, Frodo, going out your door. You step onto the road, and if you don’t keep your feet, there’s no knowing where you might be swept off to", "The purpose of life, after all, is to live it, to taste experience to the utmost, to reach out eagerly and without fear for newer and richer experience", "Earth and sky, woods and fields, lakes and rivers, the mountain and the sea, are excellent schoolmasters, and teach some of us more that what we could learn from books"]
    }
    
    static let goldColor = UIColor.rgbColor(red: 234, green: 180, blue: 55, alpha: 1)
    static let purpleColor = UIColor.rgbColor(red: 136, green: 50, blue: 54, alpha: 1)
}


