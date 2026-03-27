//
//  KeyTagBar.swift
//  WebCraft
//
//  Quick reference bar for key tags
//

import SwiftUI

struct KeyTagBar: View {
    let tags: [String]
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "tag.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(color)
                Text("Key Tags")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.textPrimary.opacity(0.9))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 13, design: .monospaced))
                            .foregroundColor(color)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.textPrimary.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surfaceBackground.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
