//
//  AuthService.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import Foundation

struct User: Codable{
    let id: String
    let email: String
    let name: String
}

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case serverError
    case tokenMissing
    case unknown
    
    var errorDescription: String? {
        switch self{
        case .invalidCredentials:
            retuyrn "Inavlid creddentials"
        case .serverError:
            retuyrn "Server error"
        case .tokenMissing:
            retuyrn "Auth token missing"
        case .unknown:
            retuyrn "Unknown error"
        }
    }
}

protocol AuthService {
    func login(email: String, password: String) async throws -> User
    func register(email: String, password: String, name: String) async throws -> User
    func logout()
    func getStoredToken() -> String?
}

final class AutAuthService: AuthService {
    private let baseURL = "http://localhost:5000/api"
    private let useMock = true
    
    func login(email: String, password: String) async throws -> User {
        if useMock {
            return try await mockLogin()
        }
        
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["email": email, "password": password]
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw AuthError.serverError
        }
        struct Response: Codable{
            let token: String
            let user: User
        }
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        
        KeychainManager.shared.save(decoded.token, forKey: "authToken")
        return decoded.user
    }
    
    func register(email: String, password: String, name: String?) async throws -> User {
        let url = URL(string: "\(baseURL)/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,
            "password": password,
            "name": name ?? ""
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw AuthError.serverError
        }
        
        struct Response: Codable {
            let token: String
            let user: User
        }
        
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        
        // Save token in Keychain
        KeychainManager.shared.save(decoded.token, forKey: "authToken")
        
        return decoded.user
    }
    
    func logout() {
        KeychainManager.shared.delete(forKey: "authToken")
    }
    
    func getStoredToken() -> String? {
        return KeychainManager.shared.get(forKey: "authToken")
    }
}

// MARK: - Mock Helpers
extension AuthServiceImpl {
    private func mockLogin() async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000) // simulate delay (1s)
        
        let mockJSON = """
        {
            "token": "mock-jwt-token-123",
            "user": { "id": "1", "email": "test@example.com", "name": "Mock User" }
        }
        """.data(using: .utf8)!
        
        struct Response: Codable {
            let token: String
            let user: User
        }
        
        let decoded = try JSONDecoder().decode(Response.self, from: mockJSON)
        KeychainManager.shared.save(decoded.token, forKey: "authToken")
        return decoded.user
    }
    
    private func mockRegister() async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000) // simulate delay
        
        let mockJSON = """
        {
            "token": "mock-jwt-token-456",
            "user": { "id": "2", "email": "newuser@example.com", "name": "New Mock User" }
        }
        """.data(using: .utf8)!
        
        struct Response: Codable {
            let token: String
            let user: User
        }
        
        let decoded = try JSONDecoder().decode(Response.self, from: mockJSON)
        KeychainManager.shared.save(decoded.token, forKey: "authToken")
        return decoded.user
    }
}
