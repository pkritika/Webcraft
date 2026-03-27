import SwiftUI

extension Color {
    // Helper to create dynamic colors for light/dark mode
    private static func dynamicColor(light: String, dark: String) -> Color {
        return Color(UIColor { traitCollection in
            let isDark = traitCollection.userInterfaceStyle == .dark
            return UIColor(Color(hex: isDark ? dark : light))
        })
    }
    
    // MARK: - Background Colors
    static let appBackground = dynamicColor(light: "F9FAFB", dark: "1C1C1E")
    static let cardBackground = dynamicColor(light: "FFFFFF", dark: "2C2C2E")
    static let surfaceBackground = dynamicColor(light: "E5E7EB", dark: "3A3A3C")
    
    // MARK: - Accent Colors
    // (We keep these mostly vibrant in both modes, slightly tweaked if necessary)
    static let appPrimary = dynamicColor(light: "2563EB", dark: "3B82F6")
    static let appSecondary = dynamicColor(light: "4F46E5", dark: "6366F1")
    
    // MARK: - Text Colors
    static let textPrimary = dynamicColor(light: "111827", dark: "FFFFFF")
    static let textSecondary = dynamicColor(light: "4B5563", dark: "8E8E93")
    static let textTertiary = dynamicColor(light: "9CA3AF", dark: "636366")
    
    // MARK: - Semantic Colors
    static let appSuccess = dynamicColor(light: "059669", dark: "34C759")
    static let appWarning = dynamicColor(light: "D97706", dark: "FF9500")
    static let appError = dynamicColor(light: "DC2626", dark: "FF3B30")
    
    // MARK: - UI Elements
    static let appBorder = dynamicColor(light: "E5E7EB", dark: "38383A")
    static let appDisabled = dynamicColor(light: "D1D5DB", dark: "48484A")
    
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
