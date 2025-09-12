//
//  APIClient.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-11.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    private init() {}
   
    private let baseURL = "https://momentum-backend-cibu.onrender.com/api"
    
    // Generic request function
    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: [String: Any]? = nil,
        requiresAuth: Bool = true,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth, let token = KeychainHelper.shared.get("authToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("❌ Decoding error:", error)
                print("🔍 Raw response:", String(data: data, encoding: .utf8) ?? "nil")
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - Errors
enum APIError: Error {
    case invalidURL
    case noData
}
