//
//  Keychains.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/02/2024.
//

import Foundation

class Keychains {
    
    static let shared = Keychains()
    
    func save(object:Any, key:String) throws {
        let stringData = (object as! String).data(using: .utf8)!
        
        let keychainAttrs: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: stringData
        ]
        
        let _ = SecItemAdd(keychainAttrs as CFDictionary, nil)
        
        do {
            try update(string: object as! String, key: key)
        } catch {
            throw error
        }
    }
    
    func update(string: String, key: String) throws {
        let key = key as CFString
        let value = string
        let data = value.data(using: .utf8) as CFData?
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data!
        ]
        
        let _ = SecItemUpdate(query as CFDictionary, [kSecValueData: data!] as CFDictionary)
        
    }
    
    func delete(key: String) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeychainErrors.deleteFailure
        }
    }
    
    func getValue(key: String) throws -> String {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecReturnData as String: kCFBooleanTrue!,
                                    kSecMatchLimit as String: kSecMatchLimitOne]
        
        var dataTypeRef: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess else {
            throw KeychainErrors.fetchFailure
        }
        
        guard let retrievedData = dataTypeRef as? Data else {
            throw KeychainErrors.fetchFailure
        }
        
        guard let value = String(data: retrievedData, encoding: .utf8) else {
            throw KeychainErrors.fetchFailure
        }
        
        return value
    }
    
    func empty() throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else {
            throw KeychainErrors.emptyfailure
        }
    }
    
    private init(){}
}
