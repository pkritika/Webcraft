//
//  CelebrationOverlay.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

enum CelebrationType {
    case lessonComplete(xp: Int, lessonTitle: String)
    case badgeUnlocked(badge: Badge)
    case levelUp(oldLevel: Int, newLevel: Int)
    case streakMilestone(days: Int)
}

struct CelebrationOverlay: View {
    let type: CelebrationType
    let onDismiss: () -> Void
    
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            // Background confetti
            ConfettiView(particleCount: 50)
                .ignoresSafeArea()
            
            // Semi-transparent background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }
            
            // Celebration content
            VStack(spacing: 20) {
                celebrationIcon
                    .font(.system(size: 80))
                    .scaleEffect(scale)
                
                celebrationText
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Button("Continue") {
                    dismiss()
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Color.appPrimary)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.cardBackground)
                    .shadow(radius: 20)
            )
            .padding(40)
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                scale = 1.0
                opacity = 1.0
            }
            
            // Auto-dismiss after 4 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                dismiss()
            }
        }
    }
    
    private var celebrationIcon: some View {
        Group {
            switch type {
            case .lessonComplete:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.appSuccess)
            case .badgeUnlocked:
                Image(systemName: "star.circle.fill")
                    .foregroundColor(.yellow)
            case .levelUp:
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.appPrimary)
            case .streakMilestone:
                Image(systemName: "flame.fill")
                    .foregroundColor(.appWarning)
            }
        }
    }
    
    private var celebrationText: some View {
        Group {
            switch type {
            case .lessonComplete(let xp, let lessonTitle):
                VStack(spacing: 8) {
                    Text("Lesson Complete!")
                        .font(.title)
                        .bold()
                    Text(lessonTitle)
                        .font(.headline)
                        .foregroundColor(.textSecondary)
                    Text("+\(xp) XP")
                        .font(.title2)
                        .foregroundColor(.appPrimary)
                }
            case .badgeUnlocked(let badge):
                VStack(spacing: 8) {
                    Text("Badge Unlocked!")
                        .font(.title)
                        .bold()
                    Image(systemName: badge.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                    Text(badge.title)
                        .font(.headline)
                    Text(badge.description)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            case .levelUp(let oldLevel, let newLevel):
                VStack(spacing: 8) {
                    Text("Level Up!")
                        .font(.title)
                        .bold()
                    HStack(spacing: 12) {
                        Text("\(oldLevel)")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.gray)
                        Image(systemName: "arrow.right")
                            .font(.title2)
                        Text("\(newLevel)")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.appPrimary)
                    }
                }
            case .streakMilestone(let days):
                VStack(spacing: 8) {
                    Text("Streak Milestone!")
                        .font(.title)
                        .bold()
                    Text("\(days) Day Streak")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.orange)
                    Text("Keep it going!")
                        .font(.headline)
                        .foregroundColor(.textSecondary)
                }
            }
        }
    }
    
    private func dismiss() {
        withAnimation(.easeOut(duration: 0.3)) {
            opacity = 0
            scale = 0.8
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onDismiss()
        }
    }
}
