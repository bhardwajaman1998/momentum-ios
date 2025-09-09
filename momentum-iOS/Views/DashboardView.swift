import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            NewEntryView()
                .tabItem {
                    Label("Entry", systemImage: "square.and.pencil")
                }
            MoodOverviewView()
                .tabItem {
                    Label("Overview", systemImage: "chart.line.uptrend.xyaxis")
                }
            InsightsView()
                .tabItem {
                    Label("Insights", systemImage: "lightbulb")
                }
            MoodHeatmapView()
                .tabItem {
                    Label("Heatmap", systemImage: "calendar")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
