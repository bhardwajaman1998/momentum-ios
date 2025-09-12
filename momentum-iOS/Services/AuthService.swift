//
//  AuthService.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let password: String?      // nullable field in backend
    let name: String
    let avatarUrl: String?     // nullable in backend
    let streak: Int
    let darkMode: Bool
    let createdAt: String      // you can switch to Date later with custom decoder
}
enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case serverError
    case tokenMissing
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid credentials"
        case .serverError:
            return "Server error"
        case .tokenMissing:
            return "Auth token missing"
        case .unknown:
            return "Unknown error"
        }
    }
}

protocol AuthService {
    func login(email: String, password: String) async throws -> User
    func register(email: String, password: String, name: String?) async throws -> User
    func logout()
    func getStoredToken() -> String?
}

final class AuthServiceImpl: AuthService {
    
    private let client = APIClient.shared
    
    func login(email: String, password: String) async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            client.request(endpoint: "/auth/login", method: "POST", body: [
                "email": email,
                "password": password
            ]) { (result: Result<AuthResponse, Error>) in
                switch result {
                case .success(let response):
                    if let token = response.token, let user = response.user {
                        print(response)
                        KeychainHelper.shared.save(token, forKey: "authToken")
                        continuation.resume(returning: user)
                    } else if let errorMsg = response.error {
                        // ✅ Server sent an error
                        continuation.resume(throwing: NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: errorMsg]))
                    } else {
                        // ✅ Fallback error
                        continuation.resume(throwing: AuthError.unknown)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    
    func register(email: String, password: String, name: String?) async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            client.request(endpoint: "/auth/signup", method: "POST", body: [
                "email": email,
                "password": password,
                "name": name ?? "null"
            ]) { (result: Result<AuthResponse, Error>) in
                switch result {
                case .success(let response):
                    KeychainHelper.shared.save(response.token ?? "null", forKey: "authToken")
                    continuation.resume(returning: response.user!)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func logout() {
        KeychainHelper.shared.delete("authToken")
    }
    
    func getStoredToken() -> String? {
        return KeychainHelper.shared.get("authToken")
    }
}

struct AuthResponse: Codable {
    let token: String?
    let user: User?
    let error: String?
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
