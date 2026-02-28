import SwiftUI
struct LessonCard: View {
    @EnvironmentObject var progressService: ProgressService
    let lesson: Lesson
    let isLocked: Bool
    let isCompleted: Bool
    var body: some View {
        NavigationLink(destination: LessonHubView(lesson: lesson)) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? Color.appSuccess : Color.appPrimary)
                        .frame(width: 50, height: 50)
                    
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .foregroundColor(.textPrimary)
                            .font(.title3)
                    } else if isLocked {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.textPrimary)
                    } else {
                        Text("\(lesson.id)")
                            .foregroundColor(.textPrimary)
                            .bold()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(lesson.title)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    Text(lesson.description)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)
                    
                    Text("\(lesson.xpReward) XP")
                        .font(.caption)
                        .foregroundColor(.appPrimary)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .opacity(isLocked ? 0.5 : 1)
        }
        .disabled(isLocked)
    }
}
