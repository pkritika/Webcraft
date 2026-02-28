import SwiftUI

struct QuizView: View {
    let quiz: Quiz
    let onCorrect: () -> Void
    
    @State private var selectedIndex: Int?
    @State private var hasSubmitted = false
    @State private var isCorrect = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Question
            Text(quiz.question)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            
            // Options
            VStack(spacing: 12) {
                ForEach(0..<quiz.options.count, id: \.self) { index in
                    Button(action: {
                        if !hasSubmitted {
                            selectedIndex = index
                            HapticManager.shared.trigger(.selection)
                        }
                    }) {
                        HStack {
                            Text(quiz.options[index])
                                .font(.system(size: 15))
                                .foregroundColor(getTextColor(for: index))
                            
                            Spacer()
                            
                            if hasSubmitted {
                                if index == quiz.correctAnswerIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else if index == selectedIndex && index != quiz.correctAnswerIndex {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            } else if selectedIndex == index {
                                Image(systemName: "circle.inset.filled")
                                    .foregroundColor(Color(hex: "#5E6AD2"))
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray.opacity(0.5))
                            }
                        }
                        .padding(16)
                        .background(getBackgroundColor(for: index))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(getBorderColor(for: index), lineWidth: 2)
                        )
                    }
                    .disabled(hasSubmitted)
                }
            }
            
            // Explanation (only shows after incorrect submission)
            if hasSubmitted && !isCorrect, let explanation = quiz.explanation {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title3)
                    
                    Text(explanation)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding()
                .background(Color.orange.opacity(0.15))
                .cornerRadius(12)
            }
            
            // Correct feedback
            if hasSubmitted && isCorrect {
                HStack(spacing: 12) {
                    Image(systemName: "party.popper.fill")
                        .foregroundColor(.green)
                        .font(.title3)
                    
                    Text("Correct! Great job!")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color.green.opacity(0.15))
                .cornerRadius(12)
            }
            
            Spacer()
            
            // Check / Continue Button
            Button(action: handleButtonPress) {
                HStack(spacing: 8) {
                    Text(getButtonText())
                        .font(.system(size: 16, weight: .semibold))
                    
                    Image(systemName: getButtonIcon())
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(getButtonForeground())
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(getButtonColor())
                .cornerRadius(12)
            }
            .disabled(selectedIndex == nil)
            .opacity(selectedIndex == nil ? 0.4 : 1)
        }
        .padding(24)
        .background(Color.white.opacity(0.08))
        .cornerRadius(16)
    }
    
    // Logic Helpers
    
    private func handleButtonPress() {
        if hasSubmitted && isCorrect {
            onCorrect()
        } else if hasSubmitted && !isCorrect {
            // Retry
            hasSubmitted = false
            selectedIndex = nil
        } else {
            // Submit
            hasSubmitted = true
            isCorrect = (selectedIndex == quiz.correctAnswerIndex)
            
            if isCorrect {
                HapticManager.shared.trigger(.success)
            } else {
                HapticManager.shared.trigger(.error)
            }
        }
    }
    
    private func getButtonText() -> String {
        if hasSubmitted && isCorrect {
            return "Continue"
        } else if hasSubmitted && !isCorrect {
            return "Try Again"
        }
        return "Check Answer"
    }
    
    private func getButtonIcon() -> String {
        if hasSubmitted && isCorrect {
            return "arrow.right"
        } else if hasSubmitted && !isCorrect {
            return "arrow.counterclockwise"
        }
        return "checkmark"
    }
    
    private func getButtonForeground() -> Color {
        if hasSubmitted && isCorrect {
            return .black
        }
        return .white
    }
    
    private func getButtonColor() -> Color {
        if hasSubmitted {
            return isCorrect ? .green : Color.white.opacity(0.15)
        }
        return Color(hex: "#5E6AD2")
    }
    
    // UI Helpers
    
    private func getBackgroundColor(for index: Int) -> Color {
        if hasSubmitted {
            if index == quiz.correctAnswerIndex {
                return Color.green.opacity(0.15)
            } else if index == selectedIndex {
                return Color.red.opacity(0.15)
            }
        } else if index == selectedIndex {
            return Color(hex: "#5E6AD2").opacity(0.15)
        }
        return Color.white.opacity(0.05)
    }
    
    private func getBorderColor(for index: Int) -> Color {
        if hasSubmitted {
            if index == quiz.correctAnswerIndex {
                return .green
            } else if index == selectedIndex {
                return .red
            }
        } else if index == selectedIndex {
            return Color(hex: "#5E6AD2")
        }
        return Color.white.opacity(0.1)
    }
    
    private func getTextColor(for index: Int) -> Color {
        if hasSubmitted {
            if index == quiz.correctAnswerIndex {
                return .green
            } else if index == selectedIndex {
                return .red
            }
        } else if index == selectedIndex {
            return Color(hex: "#5E6AD2")
        }
        return .white.opacity(0.9)
    }
}
