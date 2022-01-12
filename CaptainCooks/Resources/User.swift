//
//  User.swift
//  CaptainCooks
//
//  Created by Prokopenko Ihor on 12.01.2022.
//

import UIKit

struct UserDefault {
    
    static var coins: Int {
        get {
            return UserDefaults.standard.integer(forKey: "coins")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coins")
        }
    }
    
    static var launchedFirstTime: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "launchedFirstTime")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "launchedFirstTime")
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
    
    static var currentDate: Date {
        get {
            return UserDefaults.standard.object(forKey: "currentDate") as! Date
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "currentDate")
        }
    }
    
    static var isMutedSound: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isMutedSound")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isMutedSound")
        }
    }
    
    static var isMutedBackgroundMusic: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isMutedBackgroundMusic")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isMutedBackgroundMusic")
        }
    }
    
    
}
