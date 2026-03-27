import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var progressService: ProgressService

    var nextLesson: Lesson? {
        LessonContent.allLessons.first {
            !progressService.isLessonCompleted($0) && progressService.isLessonUnlocked($0)
        }
    }

    var completedCount: Int { progressService.userProgress.completedLessonIds.count }
    var totalLessons: Int   { LessonContent.allLessons.count }

    @State private var showCheatSheet = false

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    headerSection
                    cheatSheetButton
                    statsRow
                    xpSection

                    if let lesson = nextLesson {
                        continueLearningCard(lesson: lesson)
                    } else {
                        allCompleteCard
                    }

                    lessonsProgressSection
                    Spacer(minLength: 20)
                }
                .padding(.top, 8)
            }
            .background(PremiumBackground())
            .navigationBarHidden(true)
            .sheet(isPresented: $showCheatSheet) {
                CheatSheetView()
            }
        }
        .navigationViewStyle(.stack)
    }

    // MARK: - Cheat Sheet Button

    private var cheatSheetButton: some View {
        Button(action: { showCheatSheet = true }) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "0E7490").opacity(0.2))
                        .frame(width: 40, height: 40)
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(hex: "22D3EE"))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("HTML & CSS Cheat Sheet")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.textPrimary)
                    Text("Quick reference — tap to open")
                        .font(.system(size: 12))
                        .foregroundColor(.textSecondary)
                }
                Spacer()
                Image(systemName: "arrow.up.right.square")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "22D3EE").opacity(0.8))
            }
            .padding(14)
            .background(Color.cardBackground)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(hex: "0E7490").opacity(0.35), lineWidth: 1)
            )
            .shadow(color: Color(hex: "0E7490").opacity(0.15), radius: 8, x: 0, y: 3)
        }
        .buttonStyle(ScaleButtonStyle())
        .padding(.horizontal, 20)
    }

    // MARK: - Header

    private var headerSection: some View {
        HStack(spacing: 14) {
            // Avatar circle with indigo accent
            ZStack {
                Circle()
                    .fill(Color(hex: "6366F1").opacity(0.2))
                    .frame(width: 58, height: 58)
                Circle()
                    .stroke(Color(hex: "6366F1").opacity(0.5), lineWidth: 1.5)
                    .frame(width: 58, height: 58)
                Text(String(progressService.userProgress.userName.prefix(1)).uppercased())
                    .font(.title2).bold()
                    .foregroundColor(Color(hex: "818CF8"))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(greeting)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                Text(progressService.userProgress.userName)
                    .fontRounded(style: .title2, weight: .bold)
                    .foregroundColor(.textPrimary)
            }

            Spacer()

            // Streak badge
            if progressService.userProgress.currentStreak > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Text("\(progressService.userProgress.currentStreak)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(
                    Capsule().fill(Color(hex: "F97316"))
                )
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Stats Row

    private var statsRow: some View {
        HStack(spacing: 12) {
            ColoredStatCard(
                icon: "bolt.fill",
                value: "\(progressService.userProgress.currentLevel)",
                label: "Level",
                accentHex: "6366F1"   // indigo
            )
            ColoredStatCard(
                icon: "star.fill",
                value: "\(progressService.userProgress.totalXP)",
                label: "Total XP",
                accentHex: "EC4899"   // pink
            )
            ColoredStatCard(
                icon: "checkmark.circle.fill",
                value: "\(completedCount)",
                label: "Lessons",
                accentHex: "10B981"   // green
            )
        }
        .padding(.horizontal, 20)
    }

    // MARK: - XP Progress Bar

    private var xpSection: some View {
        XPProgressBar(
            currentXP: progressService.userProgress.totalXP,
            currentLevel: progressService.userProgress.currentLevel
        )
        .padding(.horizontal, 20)
    }

    // MARK: - Continue Learning Card

    private func continueLearningCard(lesson: Lesson) -> some View {
        // Pick accent by module position
        let moduleColors = ["6366F1","EC4899","0E7490","F59E0B","065F46","5B21B6","1E40AF"]
        let allModules = Array(
            OrderedSet(LessonContent.allLessons.filter { !$0.isAssessment }.map { $0.moduleTitle })
        )
        let mIdx = allModules.firstIndex(of: lesson.moduleTitle) ?? 0
        let accentHex = moduleColors[min(mIdx, moduleColors.count - 1)]
        let accent = Color(hex: accentHex)

        return NavigationLink(destination: LessonView(lesson: lesson)) {
            VStack(alignment: .leading, spacing: 0) {
                // Coloured top strip
                HStack(spacing: 10) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Text("Continue Learning")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(accent)

                // Content
                VStack(alignment: .leading, spacing: 8) {
                    Text(lesson.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.textPrimary)

                    HStack(spacing: 16) {
                        Label(lesson.difficulty.rawValue, systemImage: "speedometer")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                        Label("+\(lesson.xpReward) XP", systemImage: "star.fill")
                            .font(.caption)
                            .foregroundColor(Color(hex: "F59E0B"))
                    }
                }
                .padding(16)
            }
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(accent.opacity(0.35), lineWidth: 1)
            )
            .shadow(color: accent.opacity(0.2), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(ScaleButtonStyle())
        .padding(.horizontal, 20)
    }

    // MARK: - All Complete Card

    private var allCompleteCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "crown.fill")
                .font(.system(size: 40))
                .foregroundColor(Color(hex: "FBBF24"))
            Text("All Lessons Complete! 🎉")
                .font(.title3).bold()
                .foregroundColor(.textPrimary)
            Text("You've mastered all the content. Keep building your portfolio!")
                .font(.subheadline)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "FBBF24").opacity(0.4), lineWidth: 1)
        )
        .shadow(color: Color(hex: "FBBF24").opacity(0.15), radius: 12, x: 0, y: 6)
        .padding(.horizontal, 20)
    }

    // MARK: - Course Progress

    private var lessonsProgressSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Course Progress")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.textPrimary)
                Spacer()
                Text("\(completedCount)/\(totalLessons)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.textSecondary)
            }

            // Coloured dot map
            let cols = Array(repeating: GridItem(.flexible(), spacing: 6), count: 10)
            LazyVGrid(columns: cols, spacing: 8) {
                ForEach(LessonContent.allLessons, id: \.id) { lesson in
                    Circle()
                        .fill(
                            progressService.isLessonCompleted(lesson)
                                ? Color(hex: "10B981")               // green
                                : progressService.isLessonUnlocked(lesson)
                                    ? Color(hex: "38BDF8").opacity(0.7)  // blue
                                    : Color.white.opacity(0.08)
                        )
                        .frame(width: 14, height: 14)
                }
            }

            // Legend
            HStack(spacing: 16) {
                LegendDot(color: Color(hex: "10B981"), label: "Done")
                LegendDot(color: Color(hex: "38BDF8").opacity(0.7), label: "Unlocked")
            }
        }
        .padding(18)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "6366F1").opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }

    // MARK: - Helpers

    private var greeting: String {
        let h = Calendar.current.component(.hour, from: Date())
        switch h {
        case 5..<12: return "Good morning,"
        case 12..<17: return "Good afternoon,"
        case 17..<21: return "Good evening,"
        default:      return "Welcome"
        }
    }
}

// MARK: - Coloured Stat Card

struct ColoredStatCard: View {
    let icon: String
    let value: String
    let label: String
    let accentHex: String

    private var accent: Color { Color(hex: accentHex) }

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(accent.opacity(0.18))
                    .frame(width: 46, height: 46)
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(accent)
            }
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.textPrimary)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(accent.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: accent.opacity(0.12), radius: 8, x: 0, y: 3)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }
}

// MARK: - Legend Dot

private struct LegendDot: View {
    let color: Color
    let label: String
    var body: some View {
        HStack(spacing: 5) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.textSecondary)
        }
    }
}

// MARK: - Ordered Set helper (preserves insertion order)

private struct OrderedSet<T: Hashable>: Sequence {
    private var storage: [T] = []
    private var seen:    Set<T> = []
    init<S: Sequence>(_ s: S) where S.Element == T {
        for el in s where seen.insert(el).inserted { storage.append(el) }
    }
    func makeIterator() -> IndexingIterator<[T]> { storage.makeIterator() }
}

// MARK: - Preview

#Preview("Dashboard") {
    DashboardView()
        .environmentObject(ProgressService.shared)
        .environmentObject(PortfolioService.shared)
}
