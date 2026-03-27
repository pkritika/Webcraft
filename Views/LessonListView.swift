import SwiftUI
struct LessonListView: View {
    @EnvironmentObject var progressService: ProgressService
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Lessons")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                List {
                    ForEach(groupedLessons.keys.sorted(), id: \.self) { moduleTitle in
                        Section(header: 
                            Text(moduleTitle)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.textPrimary)
                                .padding(.vertical, 8)
                        ) {
                            ForEach(groupedLessons[moduleTitle] ?? []) { lesson in
                                LessonCard(lesson: lesson, isLocked: !progressService.isLessonUnlocked(lesson), isCompleted: progressService.isLessonCompleted(lesson))
                                    .listRowBackground(Color.cardBackground)
                                    .listRowSeparatorTint(Color.appBorder)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .background(Color.appBackground)
                .scrollContentBackground(.hidden)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
    
    private var groupedLessons: [String: [Lesson]] {
        Dictionary(grouping: LessonContent.allLessons, by: { $0.moduleTitle })
    }
}

#Preview("Lesson List") {
    LessonListView()
        .environmentObject(ProgressService.shared)
}
