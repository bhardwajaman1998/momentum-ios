//
//  RegisterView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-04.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
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
                
                // Title + subtitle
                VStack(spacing: 8) {
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Create your account and start your journey")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                
                // Card with fields
                VStack(spacing: 16) {
                    customTextField(icon: "envelope.fill",
                                    placeholder: "Email",
                                    text: $email,
                                    isSecure: false)
                    
                    customTextField(icon: "lock.fill",
                                    placeholder: "Password",
                                    text: $password,
                                    isSecure: true)
                    
                    customTextField(icon: "lock.fill",
                                    placeholder: "Confirm Password",
                                    text: $confirmPassword,
                                    isSecure: true)
                }
                .padding()
                .background(Color.black.opacity(0.25))
                .cornerRadius(16)
                .padding(.horizontal, 24)
                
                // Sign Up button
                Button(action: {
                    print("Sign Up tapped")
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Already have account? Login
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.white.opacity(0.7))
                    NavigationLink("Log In", destination: LoginView())
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.bottom, 40)
        }
    }
    
    // MARK: - Custom TextField with Icon
    private func customTextField(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.7))
            
            if isSecure {
                SecureField("", text: text,
                            prompt: Text(placeholder).foregroundColor(.white.opacity(0.6)))
                .foregroundColor(.white)
            } else {
                TextField("", text: text,
                          prompt: Text(placeholder).foregroundColor(.white.opacity(0.6)))
                .foregroundColor(.white)
                .autocapitalization(.none)
            }
        }
        .padding()
        .background(Color.black.opacity(0.25))
        .cornerRadius(10)
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow { placeholder() }
            self
        }
    }
}
