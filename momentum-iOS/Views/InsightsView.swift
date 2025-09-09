import SwiftUI

struct Insight: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct InsightsView: View {
    private let insights: [Insight] = [
        Insight(title: "Reflections", description: "You're staying consistent with journaling. Keep it up!"),
        Insight(title: "Prompts", description: "Consider noting what triggers mood changes to gain more insight.")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(insights) { insight in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(insight.title)
                                .font(.headline)
                            Text(insight.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.secondarySystemBackground))
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Insights")
        }
    }
}
