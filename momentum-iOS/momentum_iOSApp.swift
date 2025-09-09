//
//  momentum_iOSApp.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import SwiftUI

@main
struct momentum_iOSApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                DashboardView()
                    .environmentObject(appState)
            } else {
                NavigationView {
                    LoginView()
                }
                .environmentObject(appState)
            }
        }
    }
}
