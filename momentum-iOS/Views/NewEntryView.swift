import SwiftUI

struct NewEntryView: View {
    @State private var entryText: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                TextEditor(text: $entryText)
                    .frame(height: 200)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3))
                    )
                Spacer()
            }
            .padding()
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // TODO: Handle save action
                    }
                }
            }
        }
    }
}
