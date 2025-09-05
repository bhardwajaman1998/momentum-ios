//
//  KeychainManager.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import Foundation
import KeychainAccess

final class KeychainManager{
    static let shared = KeychainManager()
    
    private let keychain: Keychain
    
    private init() {
        let service = Bundle.main.bundleIdentifier ?? "com.example.momentum-iOS"
        keychain = Keychain(service: service)
    }
    
    func save(_ value: String, forKey key: String){
        do{
            try keychain.set(value, key: key)
            print("saved val for key: \(key)")
        } catch{
            print("error: \(error)")
        }
    }
    
    func get(forKey key: String) -> String?{
        do{
            return keychain.get(key)
        } catch {
            print("error: \(error)")
            return nil
        }
    }
    
    func delete(forKey key: String){
        do{
            try keychain.remove(key)
        } catch {
            print("error: \(error)")
        }
    }
}

//Usage:
// Save JWT
//KeychainManager.shared.save("jwt-token-value", forKey: "authToken")

// Retrieve JWT
//if let token = KeychainManager.shared.get(forKey: "authToken") {
  //  print("Token: \(token)")
//}

// Delete JWT
//KeychainManager.shared.delete(forKey: "authToken")
