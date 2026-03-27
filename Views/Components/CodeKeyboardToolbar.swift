//
//  CodeKeyboardToolbar.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct CodeKeyboardToolbar: View {
    let onInsert: (String) -> Void
    let onTab: () -> Void
    let onUndo: () -> Void
    let onRedo: () -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // Common HTML/CSS/JS characters
                ToolbarButton(symbol: "<") { onInsert("<") }
                ToolbarButton(symbol: ">") { onInsert(">") }
                ToolbarButton(symbol: "/") { onInsert("/") }
                ToolbarButton(symbol: "{") { onInsert("{") }
                ToolbarButton(symbol: "}") { onInsert("}") }
                ToolbarButton(symbol: "(") { onInsert("(") }
                ToolbarButton(symbol: ")") { onInsert(")") }
                ToolbarButton(symbol: "[") { onInsert("[") }
                ToolbarButton(symbol: "]") { onInsert("]") }
                ToolbarButton(symbol: "\"") { onInsert("\"") }
                ToolbarButton(symbol: "'") { onInsert("'") }
                ToolbarButton(symbol: ";") { onInsert(";") }
                ToolbarButton(symbol: ":") { onInsert(":") }
                ToolbarButton(symbol: "=") { onInsert("=") }
                
                Divider()
                    .frame(height: 30)
                
                // Tab for indentation
                ToolbarButton(symbol: "→", label: "Tab") { onTab() }
                
                // Undo/Redo
                ToolbarButton(systemImage: "arrow.uturn.backward") { onUndo() }
                ToolbarButton(systemImage: "arrow.uturn.forward") { onRedo() }
            }
            .padding(.horizontal, 8)
        }
        .frame(height: 44)
        .background(Color(.systemGray6))
    }
}

struct ToolbarButton: View {
    let symbol: String?
    let label: String?
    let systemImage: String?
    let action: () -> Void
    
    init(symbol: String, label: String? = nil, action: @escaping () -> Void) {
        self.symbol = symbol
        self.label = label
        self.systemImage = nil
        self.action = action
    }
    
    init(systemImage: String, action: @escaping () -> Void) {
        self.symbol = nil
        self.label = nil
        self.systemImage = systemImage
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            HapticManager.shared.trigger(.light)
            action()
        }) {
            if let systemImage = systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: 18))
                    .frame(width: 40, height: 32)
            } else {
                VStack(spacing: 2) {
                    if let symbol = symbol {
                        Text(symbol)
                            .font(.system(size: 18, weight: .medium))
                    }
                    if let label = label {
                        Text(label)
                            .font(.system(size: 8))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 40, height: 32)
            }
        }
        .foregroundColor(.primary)
        .background(Color.cardBackground)
        .cornerRadius(6)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}
