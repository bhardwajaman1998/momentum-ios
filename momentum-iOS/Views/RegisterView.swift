//
//  RegisterView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    @EnvironmentObject var appState: AppState
    private let authService: AuthService = AuthServiceImpl()

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("Name", text: $name)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

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

            Button(action: register) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
            .disabled(isLoading)

            Spacer()
        }
        .padding()
    }

    private func register() {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let user = try await authService.register(email: email, password: password, name: name)
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
