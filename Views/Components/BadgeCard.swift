import SwiftUI
struct BadgeCard: View {
    let badge: Badge
    let isUnlocked: Bool
    var body: some View {
        VStack {
            Image(systemName: badge.icon)
                .font(.largeTitle)
                .foregroundColor(isUnlocked ? .yellow : .gray)
                .opacity(isUnlocked ? 1 : 0.3)
            Text(badge.title)
                .font(.caption)
                .foregroundColor(isUnlocked ? .textPrimary : .textSecondary)
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
