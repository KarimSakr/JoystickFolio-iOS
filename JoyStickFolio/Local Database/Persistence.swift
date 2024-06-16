//
//  Persistence.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/02/2024.
//

import Foundation

class Persistence {
    
    static let instance = Persistence()
    
    private let defaults = UserDefaults.standard
    
    func save(_ object: Any, key: String) {
        defaults.set(object, forKey: key)
    }
    
    func getDouble(key: String) -> Double? {
        return defaults.double(forKey: key)
    }
    
    private init() {}
}
