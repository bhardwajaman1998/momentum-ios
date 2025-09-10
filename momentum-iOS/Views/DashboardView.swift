//
//  DashboardView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-09.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NewEntryView()
                .tabItem {
                    Label("Journal", systemImage: "book.fill")
                }
                .tag(0)
            
            MoodOverviewView()
                .tabItem {
                    Label("Mood", systemImage: "face.smiling")
                }
                .tag(1)
            
            InsightsView()
                .tabItem {
                    Label("Insights", systemImage: "sparkles")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(3)
        }
        .accentColor(.purple) // active tab color
    }
}

