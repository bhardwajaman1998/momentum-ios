//
//  AppState.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import Foundation

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    private let authService: AuthService = AuthServiceImpl()
    
    init() {
        if let _ = authService.getStoredToken() {
            self.isLoggedIn = true
        }
    }
}

