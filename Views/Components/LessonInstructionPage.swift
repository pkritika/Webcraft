//
//  LessonInstructionPage.swift
//  WebCraft
//
//  Simple instruction page for practice sections
//

import SwiftUI

struct LessonInstructionPage: View {
    let lesson: Lesson
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack(spacing: 24) {
                // Lesson Header
//                VStack(spacing: 12) {
//                    Text(lesson.title)
//                        .font(.system(size: 28, weight: .bold))
//                        .foregroundColor(.textPrimary)
//                        .multilineTextAlignment(.center)
//                    
//                    Text(lesson.description)
//                        .font(.system(size: 15))
//                        .foregroundColor(.textSecondary)
//                        .multilineTextAlignment(.center)
//                }
//                .padding(.top, 20)
//                .padding(.horizontal, 0)
                
                // Practice section content only
                if let practiceSection = lesson.sections.first(where: { $0.type == .practice }) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Section title
                        HStack(spacing: 10) {
                            Image(systemName: "pencil.line")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.appPrimary)
                            
                            Text(practiceSection.title)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.textPrimary)
                        }
                        
                        // Instructions
                        if let challenge = practiceSection.challenge {
                            VStack(alignment: .leading, spacing: 16) {
                                // Instruction
                                Text(challenge.instruction)
                                    .font(.system(size: 16))
                                    .foregroundColor(.textSecondary)
                                    .lineSpacing(6)
                                
                                // Hint (if any)
                                if let hint = challenge.hint {
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(spacing: 6) {
                                            Image(systemName: "lightbulb.fill")
                                                .font(.system(size: 14))
                                                .foregroundColor(.orange)
                                            Text("Hint:")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.textPrimary)
                                        }
                                        
                                        Text(hint)
                                            .font(.system(size: 14))
                                            .foregroundColor(.textSecondary)
                                    }
                                    .padding(14)
                                    .background(Color.orange.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                        }
                    }
                }
                
                // Scroll hint
                VStack(spacing: 8) {
                    Image(systemName: "arrow.down.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.appPrimary.opacity(0.7))
                    Text("Scroll down to start coding")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textSecondary)
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .scrollIndicators(.visible)
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .ignoresSafeArea()
    }
}
