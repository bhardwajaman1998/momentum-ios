//
//  DashboardView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Welcome, \(appState.currentUser?.name ?? "User")")
                .font(.title)
                .padding()

            Button("Logout") {
                appState.isLoggedIn = false
                appState.currentUser = nil
                KeychainManager.shared.delete(forKey: "authToken")
            }
            .foregroundColor(.red)
        }
    }
}
