//
//  SettingsInfo.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/11/24.
//

import Foundation

class SettingsInfo {
    
    static var recentV: Bool {
        get {
            return UserDefaults.standard.value(forKey: "recentV") as? Bool ?? true
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "recentV")
        }
    }
    static var recentVCount: Int {
        get {
            if recentV == false { return 0 }
            return UserDefaults.standard.value(forKey: "recentVCount") as? Int ?? 3
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "recentVCount")
        }
    }
    static var savedV: Bool {
        get {
            return UserDefaults.standard.value(forKey: "savedV") as? Bool ?? true
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "savedV")
        }
    }
    static var savedVCount: Int {
        get {
            if savedV == false { return 0 }
            return UserDefaults.standard.value(forKey: "savedVCount") as? Int ?? 3
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "savedVCount")
        }
    }
    static var followingV: Bool {
        get {
            return UserDefaults.standard.value(forKey: "followingV") as? Bool ?? true
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "followingV")
        }
    }
    static var followingVCount: Int {
        get {
            if followingV == false { return 0 }
            return UserDefaults.standard.value(forKey: "followingVCount") as? Int ?? 3
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "followingVCount")
        }
    }
    static var savedS: Bool {
        get {
            return UserDefaults.standard.value(forKey: "savedS") as? Bool ?? true
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "savedS")
        }
    }
    static var savedSCount: Int {
        get {
            if savedS == false { return 0 }
            return UserDefaults.standard.value(forKey: "savedSCount") as? Int ?? 3
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "savedSCount")
        }
    }
    static var recentS: Bool {
        get {
            return UserDefaults.standard.value(forKey: "recentS") as? Bool ?? true
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "recentS")
        }
    }
    static var recentSCount: Int {
        get {
            if recentS == false { return 0 }
            return UserDefaults.standard.value(forKey: "recentSCount") as? Int ?? 3
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "recentSCount")
        }
    }
    
    static var distanceInMiles: Bool {
        get {
            return UserDefaults.standard.value(forKey: "distanceInMiles") as? Bool ?? true
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "distanceInMiles")
        }
    }
    
    static var distanceInKilometers: Bool {
        get {
            return UserDefaults.standard.value(forKey: "distanceInKilometers") as? Bool ?? false
        }
        
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "distanceInKilometers")
        }
    }
    
    static func boolForKey(_ key: String) -> Bool
    {
        return UserDefaults.standard.value(forKey: key) as? Bool ?? true
    }
    
}
