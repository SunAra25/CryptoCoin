//
//  UserDefaultsWrapper.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import Foundation

struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    
    var value: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
