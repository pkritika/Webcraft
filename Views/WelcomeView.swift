//
//  WelcomeView.swift
//  WebCraft
//
//  Animated splash screen that auto-navigates after 5 seconds
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool
    
    // Staggered animation states
    @State private var showIcon = false
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showTagline = false
    @State private var pulseIcon = false
    @State private var fadeOut = false
    
    // Progress ring
    @State private var progress: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Background
            Color.appBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Animated Icon
                ZStack {
                    // Soft glow behind icon
                    Circle()
                        .fill(Color.appPrimary.opacity(0.1))
                        .frame(width: 140, height: 140)
                        .scaleEffect(pulseIcon ? 1.15 : 1.0)
                    
                    Circle()
                        .stroke(Color.appPrimary.opacity(0.2), lineWidth: 1)
                        .frame(width: 140, height: 140)
                        .scaleEffect(pulseIcon ? 1.15 : 1.0)
                    
                    Image(systemName: "desktopcomputer")
                        .font(.system(size: 56))
                        .foregroundColor(.appPrimary)
                        .scaleEffect(showIcon ? 1.0 : 0.3)
                        .opacity(showIcon ? 1.0 : 0)
                }
                .padding(.bottom, 32)
                
                // App Name
                Text("WebCraft")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(.textPrimary)
                    .opacity(showTitle ? 1.0 : 0)
                    .offset(y: showTitle ? 0 : 20)
                    .padding(.bottom, 8)
                
                // Subtitle
                Text("Learn to Build Websites")
                    .font(.title3)
                    .foregroundColor(.textSecondary)
                    .opacity(showSubtitle ? 1.0 : 0)
                    .offset(y: showSubtitle ? 0 : 15)
                    .padding(.bottom, 40)
                
                // Tagline with typing feel
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                        .font(.caption)
                        .foregroundColor(.appPrimary)
                    
                    Text("Code • Create • Conquer")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.textTertiary)
                        .tracking(2)
                }
                .opacity(showTagline ? 1.0 : 0)
                .offset(y: showTagline ? 0 : 10)
                
                Spacer()
                
                // Countdown progress ring
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.08), lineWidth: 3)
                        .frame(width: 44, height: 44)
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.appPrimary.opacity(0.6), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 44, height: 44)
                        .rotationEffect(.degrees(-90))
                    
                    Image(systemName: "arrow.right")
                        .font(.caption)
                        .foregroundColor(.appPrimary.opacity(0.8))
                }
                .opacity(showTagline ? 1.0 : 0)
                .padding(.bottom, 50)
            }
        }
        .opacity(fadeOut ? 0 : 1)
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        // Step 1: Icon scales in (0.3s)
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2)) {
            showIcon = true
        }
        
        // Step 2: Title fades up (0.8s)
        withAnimation(.easeOut(duration: 0.5).delay(0.6)) {
            showTitle = true
        }
        
        // Step 3: Subtitle fades up (1.2s)
        withAnimation(.easeOut(duration: 0.5).delay(1.0)) {
            showSubtitle = true
        }
        
        // Step 4: Tagline fades in (1.6s)
        withAnimation(.easeOut(duration: 0.5).delay(1.4)) {
            showTagline = true
        }
        
        // Step 5: Icon pulse loop (from 1.5s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                pulseIcon = true
            }
        }
        
        // Step 6: Progress ring fills over ~3 seconds (starts at 2s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.linear(duration: 3.0)) {
                progress = 1.0
            }
        }
        
        // Step 7: Fade out and dismiss at 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            HapticManager.shared.trigger(.selection)
            withAnimation(.easeOut(duration: 0.4)) {
                fadeOut = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showWelcome = false
            }
        }
    }
}

#Preview {
    WelcomeView(showWelcome: .constant(true))
}
