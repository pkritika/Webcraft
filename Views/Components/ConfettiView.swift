import SwiftUI

struct ConfettiView: View {
    @State private var animate = false
    
    // Number of confetti particles
    var particleCount: Int = 50
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<particleCount, id: \.self) { i in
                    ConfettiParticle(
                        animate: $animate,
                        index: i,
                        geometry: geometry
                    )
                }
            }
            .onAppear {
                animate = true
            }
        }
        .allowsHitTesting(false)
    }
}

struct ConfettiParticle: View {
    @Binding var animate: Bool
    let index: Int
    let geometry: GeometryProxy
    
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    
    // Randomize properties based on index
    var color: Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink]
        return colors[index % colors.count]
    }
    
    var shape: some Shape {
        return index % 2 == 0 ? AnyShape(Rectangle()) : AnyShape(Circle())
    }
    
    var body: some View {
        shape
            .fill(color)
            .frame(width: 8, height: 8)
            .offset(x: xOffset, y: yOffset)
            .rotationEffect(.degrees(rotation))
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                // Initialize positions around the center
                let startX = geometry.size.width / 2
                let startY = geometry.size.height / 2
                
                // Random target positions
                let endX = startX + CGFloat.random(in: -geometry.size.width/2...geometry.size.width/2)
                let endY = startY + CGFloat.random(in: -geometry.size.height/2...geometry.size.height/2)
                
                xOffset = startX
                yOffset = startY
                
                withAnimation(
                    .easeOut(duration: Double.random(in: 1.5...2.5))
                    .delay(Double.random(in: 0...0.2))
                ) {
                    xOffset = endX
                    yOffset = endY
                    rotation = Double.random(in: 360...1080)
                    scale = CGFloat.random(in: 0.5...1.5)
                }
                
                // Fade out
                withAnimation(
                    .easeIn(duration: 0.5)
                    .delay(Double.random(in: 1.5...2.0))
                ) {
                    opacity = 0
                }
            }
    }
}

// Helper to use different shapes dynamically
struct AnyShape: Shape {
    private let path: @Sendable (CGRect) -> Path
    
    init<S: Shape>(_ wrapped: S) {
        path = { rect in
            wrapped.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        path(rect)
    }
}
