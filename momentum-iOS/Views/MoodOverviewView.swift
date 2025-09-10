//
//  MoodOverviewView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-09.
//

import SwiftUI
import Charts

struct MoodPoint: Identifiable {
    let id = UUID()
    let day: String
    let value: Int
}

struct MoodOverviewView: View {
    private let data: [MoodPoint] = [
        MoodPoint(day: "Mon", value: 70),
        MoodPoint(day: "Tue", value: 68),
        MoodPoint(day: "Wed", value: 80),
        MoodPoint(day: "Thu", value: 75),
        MoodPoint(day: "Fri", value: 72),
        MoodPoint(day: "Sat", value: 85),
        MoodPoint(day: "Sun", value: 78)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Weekly Mood Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Weekly Mood")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("Average: 7.2")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("+2%")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                        
                        Text("Last 7 Days")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                        
                        Chart(data) { point in
                            LineMark(
                                x: .value("Day", point.day),
                                y: .value("Mood", point.value)
                            )
                            .interpolationMethod(.monotone) // smooth curve
                            .foregroundStyle(LinearGradient(
                                gradient: Gradient(colors: [Color.cyan, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            
                            PointMark(
                                x: .value("Day", point.day),
                                y: .value("Mood", point.value)
                            )
                            .foregroundStyle(.white)
                        }
                        .frame(height: 180)
                    }
                    .padding()
                    .background(Color.black.opacity(0.25))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Key Takeaways Card
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Key Takeaways")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Your mood has been consistently positive this week, with a slight increase towards the weekend. Keep it up!")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.teal, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("Mood Overview")
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
}
