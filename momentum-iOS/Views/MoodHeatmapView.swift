//
//  MoodHeatmapView.swift
//  momentum-iOS
//
//  Created by Aman Bhardwaj on 2025-09-09.
//

import SwiftUI

struct MoodHeatmapView: View {
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 4), count: 7)
    // Sample data representing a month of mood values (0-3)
    private let moods: [Int] = Array(repeating: 2, count: 30)

    private func color(for value: Int) -> Color {
        switch value {
        case 0: return .gray.opacity(0.3)
        case 1: return .blue.opacity(0.6)
        case 2: return .green.opacity(0.6)
        case 3: return .purple.opacity(0.6)
        default: return .gray.opacity(0.3)
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(moods.indices, id: \.self) { index in
                        Circle()
                            .fill(color(for: moods[index]))
                            .frame(width: 20, height: 20)
                    }
                }
                .padding()
            }
            .navigationTitle("Mood Heatmap")
        }
    }
}
