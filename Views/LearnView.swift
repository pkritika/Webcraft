import SwiftUI

struct LearnView: View {
    let lesson: Lesson
    @EnvironmentObject var progressService: ProgressService
    @Environment(\.dismiss) var dismiss
    @State private var currentSectionIndex = 0
    @State private var showConfetti = false
    
    // Filter only theory, example, and quiz sections
    var learnSections: [LessonSection] {
        lesson.sections.filter { $0.type == .theory || $0.type == .example || $0.type == .quiz }
    }
    
    var currentSection: LessonSection? {
        guard currentSectionIndex >= 0 && currentSectionIndex < learnSections.count else {
            return nil
        }
        return learnSections[currentSectionIndex]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Dot progress indicators
            HStack(spacing: 8) {
                ForEach(0..<learnSections.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentSectionIndex ? Color.appPrimary : (index < currentSectionIndex ? Color.appSuccess : Color.gray.opacity(0.3)))
                        .frame(width: 8, height: 8)
                        .scaleEffect(index == currentSectionIndex ? 1.3 : 1.0)
                        .animation(.spring(response: 0.3), value: currentSectionIndex)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            
            if let section = currentSection {
                if section.type == .quiz, let quiz = section.quiz {
                    // Quiz section — .id forces fresh QuizView @State per question
                    ScrollView {
                        VStack(spacing: 24) {
                            // Quiz header
                            VStack(spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 40, weight: .medium))
                                    .foregroundColor(Color(hex: "#F59E0B"))
                                
                                Text(section.title)
                                    .fontRounded(size: 24, weight: .bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 20)
                            
                            // .id(quiz.question) forces a brand-new QuizView instance
                            // every time the question changes, resetting all @State
                            QuizView(quiz: quiz, onCorrect: nextSection)
                                .id(quiz.question)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .id(section.title)  // also reset scroll position
                    .background(Color.clear)
                } else {
                    // Theory/Example — .id resets AnimatedSectionView animations per section
                    VStack(spacing: 0) {
                        AnimatedSectionView(section: section)
                            .id(section.title)
                        
                        // Navigation buttons
                        HStack(spacing: 12) {
                            if currentSectionIndex > 0 {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        currentSectionIndex -= 1
                                    }
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 14, weight: .semibold))
                                        Text("Previous")
                                            .font(.system(size: 15, weight: .medium))
                                    }
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.white.opacity(0.15))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            
                            Spacer()
                            
                            if currentSectionIndex < learnSections.count - 1 {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        currentSectionIndex += 1
                                    }
                                } label: {
                                    HStack(spacing: 6) {
                                        Text("Next")
                                            .font(.system(size: 15, weight: .semibold))
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            } else {
                                Button {
                                    showConfetti = true
                                    HapticManager.shared.triggerCelebration()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        progressService.completeLesson(lesson)
                                        dismiss()
                                    }
                                } label: {
                                    HStack(spacing: 6) {
                                        Text("Complete")
                                            .font(.system(size: 15, weight: .semibold))
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(Color.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.clear)
                    }
                }
            } else {
                // All sections done — completion screen
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("Lesson Complete!")
                        .fontRounded(style: .title, weight: .bold)
                        .foregroundColor(.white)
                    
                    Text("You've mastered the theory.")
                        .foregroundColor(.white.opacity(0.6))
                    
                    Button(action: {
                        showConfetti = true
                        HapticManager.shared.triggerCelebration()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            progressService.completeLesson(lesson)
                            dismiss()
                        }
                    }) {
                        HStack(spacing: 6) {
                            Text("Finish")
                                .font(.system(size: 16, weight: .semibold))
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 14)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.clear)
            }
        }
        .overlay {
            if showConfetti {
                ConfettiView()
            }
        }
        .background(PremiumBackground())
        .navigationTitle("Learn")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func nextSection() {
        withAnimation(.easeInOut(duration: 0.25)) {
            if currentSectionIndex < learnSections.count {
                currentSectionIndex += 1
            }
        }
    }
}

struct CodeSnippetView: View {
    let code: String
    
    var body: some View {
        Text(code)
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.1))
            .cornerRadius(8)
    }
}
