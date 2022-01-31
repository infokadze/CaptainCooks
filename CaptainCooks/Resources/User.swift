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
    
    static var slotsLevelNumber: Int {
        get {
            return UserDefaults.standard.integer(forKey: "slotsLevelNumber")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "slotsLevelNumber")
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
