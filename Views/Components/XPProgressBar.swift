import SwiftUI
struct XPProgressBar: View {
    let currentXP: Int
    let currentLevel: Int
    var progress: Double {
        LevelCalculator.progressToNextLevel(currentXP: currentXP, currentLevel: currentLevel)
    }

    var xpForNextLevel: Int {
        LevelCalculator.totalXPForLevel(currentLevel + 1)
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Level \(currentLevel)")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                Spacer()
                Text("\(currentXP) / \(xpForNextLevel) XP")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.cardBackground)
                        .frame(height: 12)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(colors: [.appPrimary, .appSecondary],
                                           startPoint: .leading,
                                           endPoint: .trailing))
                        .frame(width: geo.size.width * progress, height: 12)
                }
            }
            .frame(height: 12)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Level progress")
            .accessibilityValue("\(Int(progress * 100)) percent complete. \(currentXP) out of \(xpForNextLevel) experience points to level \(currentLevel + 1)")
        }
        .accessibilityElement(children: .contain)
    }
}
