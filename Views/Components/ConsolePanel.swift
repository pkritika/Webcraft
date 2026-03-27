//
//  ConsolePanel.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct ConsolePanel: View {
    @Binding var messages: [ConsoleMessage]
    @Binding var isExpanded: Bool
    let onClear: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "terminal.fill")
                    .foregroundColor(.green)
                Text("Console")
                    .font(.caption).bold()
                
                Spacer()
                
                if !messages.isEmpty {
                    Text("\(messages.count)")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.gray)
                        .cornerRadius(8)
                }
                
                Button(action: onClear) {
                    Image(systemName: "trash")
                        .font(.caption)
                }
                .foregroundColor(.red)
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                        .font(.caption)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            
            // Messages
            if isExpanded {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 4) {
                            if messages.isEmpty {
                                Text("Console output will appear here")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding()
                            } else {
                                ForEach(messages) { message in
                                    ConsoleMessageRow(message: message)
                                        .id(message.id)
                                }
                            }
                        }
                        .padding(8)
                    }
                    .frame(maxHeight: 150)
                    .background(Color.cardBackground)
                    .onChange(of: messages.count) { _ in
                        if let last = messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(8, corners: [.topLeft, .topRight])
    }
}

struct ConsoleMessageRow: View {
    let message: ConsoleMessage
    
    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            icon
            
            VStack(alignment: .leading, spacing: 2) {
                Text(message.message)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(textColor)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(timeString)
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(backgroundColor)
        .cornerRadius(4)
    }
    
    private var icon: some View {
        Group {
            switch message.type {
            case .log:
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.gray)
            case .error:
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            case .warn:
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
            case .info:
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .font(.caption2)
    }
    
    private var textColor: Color {
        switch message.type {
        case .log, .info: return .primary
        case .error: return .red
        case .warn: return .orange
        }
    }
    
    private var backgroundColor: Color {
        switch message.type {
        case .log, .info: return Color.clear
        case .error: return Color.red.opacity(0.05)
        case .warn: return Color.orange.opacity(0.05)
        }
    }
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: message.timestamp)
    }
}
