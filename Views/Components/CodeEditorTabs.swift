//
//  CodeEditorTabs.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct CodeEditorTabs: View {
    @Binding var selectedLanguage: CodeLanguage
    let htmlHasCode: Bool
    let cssHasCode: Bool
    let jsHasCode: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            TabButton(
                title: "HTML",
                language: .html,
                isSelected: selectedLanguage == .html,
                hasCode: htmlHasCode
            ) {
                selectedLanguage = .html
            }
            
            TabButton(
                title: "CSS",
                language: .css,
                isSelected: selectedLanguage == .css,
                hasCode: cssHasCode
            ) {
                selectedLanguage = .css
            }
            
            /*
            TabButton(
                title: "JavaScript",
                language: .javascript,
                isSelected: selectedLanguage == .javascript,
                hasCode: jsHasCode
            ) {
                selectedLanguage = .javascript
            }
            */
            
            Spacer()
        }
        .background(Color.cardBackground)
    }
}

struct TabButton: View {
    let title: String
    let language: CodeLanguage
    let isSelected: Bool
    let hasCode: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticManager.shared.trigger(.selection)
            action()
        }) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
                
                if hasCode {
                    Circle()
                        .fill(Color.appPrimary)
                        .frame(width: 6, height: 6)
                }
            }
            .foregroundColor(isSelected ? .appPrimary : .textSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                isSelected ? Color.surfaceBackground : Color.clear
            )
            .cornerRadius(8, corners: [.topLeft, .topRight])
        }
    }
}

// Helper extension for custom corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
