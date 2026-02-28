//
//  StyledActionButton.swift
//  WebCraft
//
//  Reusable styled button for lesson actions
//

import SwiftUI

enum ActionButtonStyle {
    case save, reset, check, next, complete
    
    var color: Color {
        switch self {
        case .save: return .blue
        case .reset: return .orange
        case .check: return .green
        case .next: return .appPrimary
        case .complete: return .appSuccess
        }
    }
    
    var icon: String {
        switch self {
        case .save: return "square.and.arrow.down"
        case .reset: return "arrow.counterclockwise"
        case .check: return "checkmark.circle"
        case .next: return "arrow.right"
        case .complete: return "checkmark.circle.fill"
        }
    }
}

struct StyledActionButton: View {
    let title: String
    let style: ActionButtonStyle
    let action: () -> Void
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: {
            HapticManager.shared.trigger(.light)
            action()
        }) {
            HStack(spacing: 6) {
                Image(systemName: style.icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isDisabled ? Color.gray.opacity(0.5) : style.color)
            )
            .shadow(color: style.color.opacity(0.3), radius: 4, x: 0, y: 2)
        }
        .disabled(isDisabled)
    }
}
