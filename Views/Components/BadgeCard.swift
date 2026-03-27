import SwiftUI

// Badge accent palette — cycles through vibrant colours
private let badgePalette: [String] = [
    "6366F1", // indigo
    "EC4899", // pink
    "10B981", // green
    "38BDF8", // blue
    "F59E0B", // amber
    "F97316", // orange
    "A855F7", // purple
    "14B8A6", // teal
]

struct BadgeCard: View {
    let badge: Badge
    let isUnlocked: Bool

    // Pick a colour based on stable badge id hash
    private var accent: Color {
        let idx = abs(badge.id.hashValue) % badgePalette.count
        return Color(hex: badgePalette[idx])
    }

    var body: some View {
        VStack(spacing: 10) {
            // Icon circle
            ZStack {
                Circle()
                    .fill(isUnlocked ? accent.opacity(0.2) : Color.textPrimary.opacity(0.05))
                    .frame(width: 58, height: 58)

                Circle()
                    .stroke(isUnlocked ? accent.opacity(0.4) : Color.textPrimary.opacity(0.08), lineWidth: 1)
                    .frame(width: 58, height: 58)

                Image(systemName: badge.icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(isUnlocked ? accent : Color.textPrimary.opacity(0.2))
            }

            Text(badge.title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(isUnlocked ? .textPrimary : .textSecondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            if !isUnlocked {
                Text("Locked")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color.textPrimary.opacity(0.25))
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isUnlocked ? accent.opacity(0.3) : Color.textPrimary.opacity(0.06),
                    lineWidth: 1
                )
        )
        .shadow(
            color: isUnlocked ? accent.opacity(0.15) : Color.textPrimary.opacity(0.08),
            radius: isUnlocked ? 10 : 4,
            x: 0,
            y: isUnlocked ? 4 : 2
        )
        .opacity(isUnlocked ? 1 : 0.55)
    }
}
