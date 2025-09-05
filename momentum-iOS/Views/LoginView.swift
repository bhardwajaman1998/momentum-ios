//
//  LoginView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    @EnvironmentObject var appState: AppState
    private let authService: AuthService = AuthServiceImpl()

    var body: some View {
        VStack(spacing: 20) {
            Text("Momentum")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button(action: login) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .disabled(isLoading)

            Spacer()

            NavigationLink("Don't have an account? Register", destination: RegisterView())
        }
        .padding()
    }

    private func login() {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let user = try await authService.login(email: email, password: password)
                DispatchQueue.main.async {
                    appState.currentUser = user
                    appState.isLoggedIn = true
                }
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
