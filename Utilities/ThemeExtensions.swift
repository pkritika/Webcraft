import SwiftUI

// MARK: - Typography

struct RoundedFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight
    var textStyle: Font.TextStyle?

    func body(content: Content) -> some View {
        if let style = textStyle {
            content.font(.system(style, design: .rounded).weight(weight))
        } else {
            content.font(.system(size: size, weight: weight, design: .rounded))
        }
    }
}

extension View {
    /// Applies a rounded system font of a specific size and weight
    func fontRounded(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(RoundedFontModifier(size: size, weight: weight, textStyle: nil))
    }
    
    /// Applies a rounded system font using a standard text style
    func fontRounded(style: Font.TextStyle, weight: Font.Weight = .regular) -> some View {
        self.modifier(RoundedFontModifier(size: 0, weight: weight, textStyle: style))
    }
}

// MARK: - Backgrounds & Glassmorphism

struct PremiumBackground: View {
    var body: some View {
        ZStack {
            // Solid dark slate / black theme base
            Color.appBackground
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

// MARK: - Interactive Button Styles

/// A button style that scales down slightly when pressed
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScaleButtonStyle {
    static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }
}
