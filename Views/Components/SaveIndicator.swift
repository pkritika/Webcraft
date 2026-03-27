//
//  SaveIndicator.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

enum SaveStatus {
    case saved
    case saving
    case modified
}

struct SaveIndicator: View {
    let status: SaveStatus
    
    var body: some View {
        HStack(spacing: 6) {
            switch status {
            case .saved:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Saved")
                    .font(.caption)
                    .foregroundColor(.green)
            case .saving:
                ProgressView()
                    .scaleEffect(0.7)
                Text("Saving...")
                    .font(.caption)
                    .foregroundColor(.gray)
            case .modified:
                Circle()
                    .fill(Color.orange)
                    .frame(width: 8, height: 8)
                Text("Modified")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
