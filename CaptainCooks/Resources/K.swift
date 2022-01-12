//
//  Constants.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 10.01.2022.
//

import UIKit

struct K {
    struct segueID {
        static let mainVC = "unwindToMain"
        static let settingsOrInfoVC = "goToSettingsOrInfo"
        static let bonusGameVC = "goToMatchGame"
        static let bonusMapVC = "goToBonusMap"
        static let notEnoughCoinsVC = "goToNotEnoughCoinsVC"
        static let privacyPolicy = "goToPrivacy"
    }
    
    struct  Text {
        
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
        #warning("check coins no enough logic")
        static let notEnoughCoins = """
To play this location you need to earn \(UserDefault.coins) coins. Try again when you've got enough coins
"""
    }
}

