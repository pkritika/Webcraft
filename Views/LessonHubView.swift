import SwiftUI

struct LessonHubView: View {
    @EnvironmentObject var progressService: ProgressService
    @Environment(\.dismiss) var dismiss
    
    let lesson: Lesson
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text(lesson.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(lesson.description)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 40)
                
                // Module 1: Learn (Theory + Quiz)
                Button(action: {
                    // Navigate to LearnView
                }) {
                    NavigationLink(destination: LearnView(lesson: lesson)) {
                        ModuleCard(
                            title: "Learn",
                            subtitle: "Theory & Quizzes",
                            icon: "book.fill",
                            color: .blue,
                            isCompleted: progressService.isLessonCompleted(lesson)
                        )
                    }
                }
                
                /*
                // Module 2: Practice (Coding)
                // NavigationLink(destination: PracticeView(lesson: lesson)) // Renamed LessonView to PracticeView concept
                // For now, we link to the existing LessonView but will refactor it to only show practice
                NavigationLink(destination: LessonView(lesson: lesson)) {
                    ModuleCard(
                        title: "Practice",
                        subtitle: "Write Code",
                        icon: "laptopcomputer",
                        color: .green,
                        isCompleted: progressService.isLessonCompleted(lesson)
                    )
                }
                */
                
                Spacer()
            }
            .padding()
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ModuleCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let isCompleted: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.textPrimary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.appSuccess)
                    .font(.title2)
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview("Lesson Hub") {
    NavigationView {
        LessonHubView(lesson: LessonContent.allLessons.first!)
            .environmentObject(ProgressService.shared)
    }
}
