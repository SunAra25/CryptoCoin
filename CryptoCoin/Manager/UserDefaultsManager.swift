//
//  UserDefaultsManager.swift
//  CryptoCoin
//
//  Created by 아라 on 9/8/24.
//

import Foundation

enum UserDefaultsManager {
    enum Key: String {
        case like
    }
    
    static var like = UserDefaultsWrapper(key: Key.like.rawValue, defaultValue: [String : String]())
}
