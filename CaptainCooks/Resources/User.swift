//
//  User.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 12.01.2022.
//

import UIKit

struct UserDefault {
    
    static var totalCoins: Int {
        get {
            return UserDefaults.standard.integer(forKey: "totalCoins")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "totalCoins")
        }
    }
    
    static var isLaunchedBefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLaunchedBefore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLaunchedBefore")
        }
    }
    
    
    
    static var mainLevelNumber: Int {
        get {
            return UserDefaults.standard.integer(forKey: "mainLevelNumber")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mainLevelNumber")
        }
    }
    
    static var bonusLevelNumber: Int {
        get {
            return UserDefaults.standard.integer(forKey: "bonusLevelNumber")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bonusLevelNumber")
        }
    }
    
    static var levelNumberPicked: Int {
        get {
            return UserDefaults.standard.integer(forKey: "levelNumberPicked")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "levelNumberPicked")
        }
    }
    
    static var coinsEarned: Int {
        get {
            return UserDefaults.standard.integer(forKey: "coinsEarned")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coinsEarned")
        }
    }
   
    static var currentDate: Date {
        get {
            return UserDefaults.standard.object(forKey: "currentDate") as! Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentDate")
        }
    }
    
    static var isSoundOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isSoundOn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSoundOn")
        }
    }
    
    static var isBackgroundMusicOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isBackgroundMusicOn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isBackgroundMusicOn")
        }
    }
}
