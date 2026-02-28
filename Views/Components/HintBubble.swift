//
//  HintBubble.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct HintBubble: View {
    let hints: [Hint]
    @Binding var currentLevel: HintLevel
    @Binding var isVisible: Bool
    let onInsertCode: (String) -> Void
    
    @State private var showContent = false
    
    var currentHint: Hint? {
        hints.first { $0.level == currentLevel }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                
                Text(currentHint?.text ?? "")
                    .font(.subheadline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                Button(action: dismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            
            if let code = currentHint?.code, !code.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text(code)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.cardBackground)
                        .cornerRadius(6)
                    
                    Button("Insert this code") {
                        HapticManager.shared.trigger(.light)
                        onInsertCode(code)
                        dismiss()
                    }
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.appPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
            if currentLevel.rawValue < HintLevel.solution.rawValue {
                Button("Show more detailed hint") {
                    advanceHint()
                }
                .font(.caption)
                .foregroundColor(.appPrimary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackground)
                .shadow(radius: 8)
        )
        .padding()
        .offset(y: showContent ? 0 : 100)
        .opacity(showContent ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                showContent = true
            }
        }
    }
    
    private func advanceHint() {
        HapticManager.shared.trigger(.light)
        if let nextLevel = HintLevel(rawValue: currentLevel.rawValue + 1) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                currentLevel = nextLevel
            }
        }
    }
    
    private func dismiss() {
        withAnimation(.easeOut(duration: 0.2)) {
            showContent = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            isVisible = false
        }
    }
}
