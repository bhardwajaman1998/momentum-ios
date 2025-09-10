//
//  NewEntryView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-09.
//

import SwiftUI

struct NewEntryView: View {
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Top bar
            HStack {
                Button(action: { print("Close tapped") }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
                Text("New Entry")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Button("Save") {
                    print("Save tapped")
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            // Quote
            Text("“The journey of a thousand miles begins with a single step.”")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal)
            
            // Text editor
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text("What’s on your mind?")
                        .foregroundColor(.white.opacity(0.6))
                        .padding(12)
                }
                
                TextEditor(text: $text)
                    .foregroundColor(.white)
                    .frame(height: 200)
                    .padding(8)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Floating mic button
            Button(action: { print("Mic tapped") }) {
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 70, height: 70)
                        .shadow(color: .purple, radius: 10, x: 0, y: 0)
                    
                    Image(systemName: "waveform")
                        .foregroundColor(.purple)
                        .font(.system(size: 28, weight: .bold))
                }
            }
            
            Spacer()
            
            // Tab bar is already handled by TabView
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

