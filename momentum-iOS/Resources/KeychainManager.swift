//
//  KeychainManager.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import Foundation
final class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    // MARK: - Save
    func save(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }
        
        // Delete existing item first
        delete(forKey: key)
        
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("✅ Saved value for key: \(key)")
        } else {
            print("❌ Failed to save, status: \(status)")
        }
    }
    
    // MARK: - Get
    func get(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("❌ Failed to get key: \(key), status: \(status)")
            return nil
        }
    }
    
    // MARK: - Delete
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("🗑 Deleted key: \(key)")
        } else {
            print("⚠️ Nothing to delete for key: \(key), status: \(status)")
        }
    }
}

// Save JWT
//KeychainManager.shared.save("jwt-token-value", forKey: "authToken")

// Retrieve JWT
//if let token = KeychainManager.shared.get(forKey: "authToken") {
  //  print("Token: \(token)")
//}

// Delete JWT
//KeychainManager.shared.delete(forKey: "authToken")
