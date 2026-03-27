import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var progressService: ProgressService

    private var completedLessons: Int { progressService.userProgress.completedLessonIds.count }
    private var totalLessons: Int     { LessonContent.allLessons.count }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    // ── Header ──────────────────────────────────────────
                    VStack(spacing: 0) {
                        // Coloured top banner
                        ZStack {
                            // Multi-colour stripe
                            HStack(spacing: 0) {
                                Color(hex: "6366F1")
                                Color(hex: "EC4899")
                                Color(hex: "10B981")
                                Color(hex: "38BDF8")
                            }
                            .frame(height: 100)

                            // Avatar on top of the banner
                            VStack(spacing: 0) {
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(Color.appBackground)
                                        .frame(width: 90, height: 90)
                                    Circle()
                                        .fill(Color(hex: "6366F1").opacity(0.2))
                                        .frame(width: 82, height: 82)
                                    Circle()
                                        .stroke(Color(hex: "6366F1").opacity(0.6), lineWidth: 2)
                                        .frame(width: 82, height: 82)
                                    Image(systemName: progressService.userProgress.avatarName)
                                        .font(.system(size: 36, weight: .medium))
                                        .foregroundColor(Color(hex: "818CF8"))
                                }
                                .offset(y: 45)
                            }
                        }
                        .frame(height: 100)
                        .clipped()

                        // Name + XP level below avatar
                        VStack(spacing: 6) {
                            Text(progressService.userProgress.userName)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.textPrimary)

                            Text("Level \(progressService.userProgress.currentLevel) • \(progressService.userProgress.totalXP) XP")
                                .font(.system(size: 14))
                                .foregroundColor(.textSecondary)
                        }
                        .padding(.top, 54) // offset for avatar overlap
                        .padding(.bottom, 8)
                    }
                    .background(Color.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)

                    // ── Stat Cards ──────────────────────────────────────
                    HStack(spacing: 12) {
                        ProfileStatCard(
                            icon: "bolt.fill",
                            value: "\(progressService.userProgress.currentLevel)",
                            label: "Level",
                            accentHex: "6366F1"
                        )
                        ProfileStatCard(
                            icon: "star.fill",
                            value: "\(progressService.userProgress.totalXP)",
                            label: "XP",
                            accentHex: "EC4899"
                        )
                        ProfileStatCard(
                            icon: "checkmark.circle.fill",
                            value: "\(completedLessons)/\(totalLessons)",
                            label: "Lessons",
                            accentHex: "10B981"
                        )
                        if progressService.userProgress.currentStreak > 0 {
                            ProfileStatCard(
                                icon: "flame.fill",
                                value: "\(progressService.userProgress.currentStreak)",
                                label: "Streak",
                                accentHex: "F97316"
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // ── Badges ──────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("Badges")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.textPrimary)
                            Spacer()
                            let earned = progressService.userProgress.earnedBadges.count
                            Text("\(earned)/\(Badge.allBadges.count)")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.textSecondary)
                        }

                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)],
                            spacing: 12
                        ) {
                            ForEach(Badge.allBadges, id: \.id) { badge in
                                BadgeCard(
                                    badge: badge,
                                    isUnlocked: progressService.userProgress.earnedBadges.contains(badge.id)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)

                }
                .padding(.top, 16)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Stat Card

private struct ProfileStatCard: View {
    let icon: String
    let value: String
    let label: String
    let accentHex: String

    private var accent: Color { Color(hex: accentHex) }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(accent.opacity(0.18))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(accent)
            }
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.textPrimary)
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.cardBackground)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(accent.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: accent.opacity(0.12), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview("Profile") {
    ProfileView()
        .environmentObject(ProgressService.shared)
}
