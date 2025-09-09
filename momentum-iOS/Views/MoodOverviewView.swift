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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Average: 72")
                        .font(.title2)
                        .bold()

                    Chart(data) { point in
                        LineMark(
                            x: .value("Day", point.day),
                            y: .value("Mood", point.value)
                        )
                    }
                    .frame(height: 200)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Key Takeaways")
                            .font(.headline)
                        Text("Your mood was generally positive with a mid-week boost.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Mood Overview")
        }
    }
}
