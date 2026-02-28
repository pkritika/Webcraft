import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var progressService: ProgressService
    
    var nextLesson: Lesson? {
        LessonContent.allLessons.first { !progressService.isLessonCompleted($0) && progressService.isLessonUnlocked($0) }
    }
    
    var completedCount: Int {
        progressService.userProgress.completedLessonIds.count
    }
    
    var totalLessons: Int {
        LessonContent.allLessons.count
    }
    

    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // MARK: - Header
                    headerSection
                    
                    // MARK: - Stat Cards
                    statsRow
                    
                    // MARK: - XP Progress
                    xpSection
                    
                    // MARK: - Continue Learning
                    if let lesson = nextLesson {
                        continueLearningCard(lesson: lesson)
                    } else {
                        allCompleteCard
                    }
                    
                    // MARK: - Course Progress
                    lessonsProgressSection
                    
                    
                    // MARK: - Daily Tip
                    codingTipCard
                    
                    Spacer(minLength: 20)
                }
                .padding(.top, 8)
            }
            .background(PremiumBackground())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        HStack(spacing: 16) {
            // Avatar — soft glow circle
            ZStack {
                Circle()
                    .fill(Color.appPrimary.opacity(0.15))
                    .frame(width: 60, height: 60)

                Circle()
                    .stroke(Color.appPrimary.opacity(0.4), lineWidth: 1.5)
                    .frame(width: 60, height: 60)

                Text(String(progressService.userProgress.userName.prefix(1)).uppercased())
                    .font(.title2)
                    .bold()
                    .foregroundColor(.appPrimary)
            }
            .accessibilityLabel("User avatar")
            .accessibilityHint("Displays your profile initial")
            
            VStack(alignment: .leading, spacing: 4) {
                Text(greeting)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                
                Text(progressService.userProgress.userName)
                    .fontRounded(style: .title2, weight: .bold)
                    .foregroundColor(.textPrimary)
            }
            
            Spacer()
            
            if progressService.userProgress.currentStreak > 0 {
                VStack(spacing: 2) {
                    Image(systemName: "flame.fill")
                        .font(.title2)
                        .foregroundColor(.appWarning)
                    Text("\(progressService.userProgress.currentStreak)")
                        .font(.caption2)
                        .bold()
                        .foregroundColor(.appWarning)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Current streak: \(progressService.userProgress.currentStreak) days")
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Stats Row
    
    private var statsRow: some View {
        HStack(spacing: 12) {
            DashboardStatCard(
                icon: "arrow.up.circle.fill",
                value: "\(progressService.userProgress.currentLevel)",
                label: "Level",
                color: .appPrimary
            )
            
            DashboardStatCard(
                icon: "star.fill",
                value: "\(progressService.userProgress.totalXP)",
                label: "Total XP",
                color: .appSecondary
            )
            
            DashboardStatCard(
                icon: "checkmark.circle.fill",
                value: "\(completedCount)",
                label: "Lessons",
                color: .appSuccess
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - XP Section
    
    private var xpSection: some View {
        XPProgressBar(
            currentXP: progressService.userProgress.totalXP,
            currentLevel: progressService.userProgress.currentLevel
        )
        .padding(.horizontal)
    }
    
    // MARK: - Continue Learning Card
    
    private func continueLearningCard(lesson: Lesson) -> some View {
        NavigationLink(destination: LessonView(lesson: lesson)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "play.circle.fill")
                        .font(.title2)
                        .foregroundColor(.appPrimary)
                    
                    Text("Continue Learning")
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
                
                Text(lesson.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 16) {
                    Label(lesson.difficulty.rawValue, systemImage: "speedometer")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Label("+\(lesson.xpReward) XP", systemImage: "star.fill")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(.scale)
        .padding(.horizontal)
    }
    
    // MARK: - All Complete Card
    
    private var allCompleteCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "crown.fill")
                .font(.system(size: 40))
                .foregroundColor(.yellow)
            
            Text("All Lessons Complete! 🎉")
                .font(.title3)
                .bold()
                .foregroundColor(.textPrimary)
            
            Text("You've mastered all the content. Keep building your portfolio!")
                .font(.subheadline)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color(hex: "FCD34D").opacity(0.2), Color(hex: "F59E0B").opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .environment(\.colorScheme, .dark)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "FBBF24").opacity(0.4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Lessons Progress
    
    private var lessonsProgressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Course Progress")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                Text("\(completedCount)/\(totalLessons)")
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: min(totalLessons, 10)), spacing: 6) {
                ForEach(LessonContent.allLessons, id: \.id) { lesson in
                    Circle()
                        .fill(
                            progressService.isLessonCompleted(lesson)
                            ? Color.appSuccess
                            : progressService.isLessonUnlocked(lesson)
                            ? Color.appPrimary.opacity(0.4)
                            : Color.white.opacity(0.08)
                        )
                        .frame(width: 12, height: 12)
                }
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    

    
    // MARK: - Daily Tip
    
    private var codingTipCard: some View {
        let tips = [
            ("💡", "Use semantic HTML tags like <header>, <nav>, and <footer> for better accessibility."),
            ("💡", "CSS Flexbox makes centering elements easy: display: flex; align-items: center;"),
            ("💡", "Always use alt attributes on images for screen readers."),
            ("💡", "CSS variables (--custom-property) make themes easy to maintain."),
            ("💡", "Use console.log() to debug your JavaScript code step by step."),
            ("💡", "Mobile-first design means writing CSS for small screens first."),
            ("💡", "The <meta viewport> tag is essential for responsive websites.")
        ]
        
        let todayIndex = Calendar.current.component(.day, from: Date()) % tips.count
        let tip = tips[todayIndex]
        
        return HStack(alignment: .top, spacing: 12) {
            Text(tip.0)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Tip")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.appPrimary)
                
                Text(tip.1)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Helpers
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning,"
        case 12..<17: return "Good afternoon,"
        case 17..<21: return "Good evening,"
        default: return "Night owl,"
        }
    }
}

// MARK: - Stat Card (Liquid Glass)

struct DashboardStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.textPrimary)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }
}

#Preview("Dashboard") {
    DashboardView()
        .environmentObject(ProgressService.shared)
        .environmentObject(PortfolioService.shared)
}
