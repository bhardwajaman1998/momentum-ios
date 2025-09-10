//
//  ProfileView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-09.
//

import SwiftUI

struct ProfileView: View {
    @State private var darkMode = false
    @State private var notifications = true
    
    @EnvironmentObject var appState: AppState
    private let authService: AuthService = AuthServiceImpl()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Avatar + Name
                    VStack(spacing: 8) {
                        Circle()
                            .fill(Color.purple.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            )
                        
                        Text("Sophia Carter")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("@sophia.carter")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    // Stats row
                    HStack(spacing: 40) {
                        statView(number: "14", label: "Streak")
                        statView(number: "28", label: "Journals")
                        statView(number: "12", label: "Badges")
                    }
                    
                    // Settings list
                    VStack(spacing: 12) {
                        toggleRow(icon: "bell.fill", title: "Notifications", isOn: $notifications)
                        
                        navigationRow(icon: "questionmark.circle", title: "Help & Support")
                    }
                    .padding(.horizontal)
                    Button(action: logout) {
                        Text("Log Out")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.9), Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
    
    // MARK: - Components
    private func statView(number: String, label: String) -> some View {
        VStack {
            Text(number)
                .font(.headline)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
    
    private func toggleRow(icon: String, title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: isOn)
                .labelsHidden()
        }
        .padding()
        .background(Color.black.opacity(0.25))
        .cornerRadius(12)
    }
    
    private func navigationRow(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.black.opacity(0.25))
        .cornerRadius(12)
    }
    
    private func logout() {
        authService.logout()
        appState.currentUser = nil
        appState.isLoggedIn = false
    }
}
