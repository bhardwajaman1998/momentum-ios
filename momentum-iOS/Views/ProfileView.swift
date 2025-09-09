import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .foregroundColor(.purple)
                        VStack(alignment: .leading) {
                            Text(appState.currentUser?.name ?? "User")
                                .font(.headline)
                            Text(appState.currentUser?.email ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Entries")
                        Spacer()
                        Text("14")
                    }
                    HStack {
                        Text("Streak")
                        Spacer()
                        Text("28 days")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        appState.isLoggedIn = false
                        appState.currentUser = nil
                        KeychainManager.shared.delete(forKey: "authToken")
                    } label: {
                        Text("Logout")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
        }
    }
}
