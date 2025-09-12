//
//  WelcomeView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-09.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {   // 👈 Add this
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.black]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    // Title
                    VStack(spacing: 8) {
                        Text("MindMeld")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Your AI-powered journal and mood coach")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    
                    // Glassy card with actions
                    VStack(spacing: 16) {
                        NavigationLink(destination: RegisterView()) {
                            Text("Sign Up")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Log In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.25))
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                    
                    // Divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white.opacity(0.3))
                        Text("Or continue with")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white.opacity(0.3))
                    }
                    .padding(.horizontal, 32)
                    
                    // Social buttons
                    HStack(spacing: 20) {
                        socialButton(icon: "apple_logo")
                        socialButton(icon: "google_logo")
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 40)
            }
        }
    }
    
    // MARK: - Social Button
    private func socialButton(icon: String) -> some View {
        Button(action: {
            print("\(icon) tapped")
        }) {
            if icon.contains("logo") {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.white.opacity(0.15))
                    .clipShape(Circle())
            } else {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.15))
                    .clipShape(Circle())
            }
        }
    }
}

