import SwiftUI

struct CheatSheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cheat Sheet")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.textPrimary)
                    Text("HTML & CSS quick reference")
                        .font(.system(size: 13))
                        .foregroundColor(.textSecondary)
                }
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.textSecondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(Color.cardBackground)

            Divider().opacity(0.15)

            // Render the cheat sheet HTML
            HTMLPreview(
                htmlContent: CheatSheetHTML.content,
                cssContent: nil,
                jsContent: nil
            )
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
}

#Preview {
    CheatSheetView()
}
