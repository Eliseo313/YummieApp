//
//  UserDefaults+Extension.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 26/07/24.
//

import Foundation

extension UserDefaults{
    private enum UserDefaultKeys: String{
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get{
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}

