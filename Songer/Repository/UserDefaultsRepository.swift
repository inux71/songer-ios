//
//  UserDefaultsRepository.swift
//  Songer
//
//  Created by Kacper Grabiec on 06/04/2025.
//

import Foundation

class UserDefaultsRepository {
    func getString(forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func save<T>(_ value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func clear() {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        userDefaults.dictionaryRepresentation().keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
}
