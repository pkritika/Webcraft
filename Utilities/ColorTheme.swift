//
//  ColorTheme.swift
//  WebCraft
//
//  Modern dark theme color palette
//

import SwiftUI

extension Color {
    // MARK: - Background Colors
    static let appBackground = Color(hex: "1C1C1E")
    static let cardBackground = Color(hex: "2C2C2E")
    static let surfaceBackground = Color(hex: "3A3A3C")
    
    // MARK: - Accent Colors
    static let appPrimary = Color(hex: "007AFF")
    static let appSecondary = Color(hex: "5E5CE6")
    
    // MARK: - Text Colors
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "8E8E93")
    static let textTertiary = Color(hex: "636366")
    
    // MARK: - Semantic Colors
    static let appSuccess = Color(hex: "34C759")
    static let appWarning = Color(hex: "FF9500")
    static let appError = Color(hex: "FF3B30")
    
    // MARK: - UI Elements
    static let appBorder = Color(hex: "38383A")
    static let appDisabled = Color(hex: "48484A")
    
    // MARK: - Hex Color Initializer
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
