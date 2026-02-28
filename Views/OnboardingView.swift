//
//  OnboardingView.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct OnboardingStep {
    let title: String
    let description: String
    let icon: String
    let color: Color
}

struct OnboardingView: View {
    let onComplete: () -> Void
    
    @State private var currentStep = 0
    @State private var opacity: Double = 0
    @State private var scale: CGFloat = 0.8
    
    private let steps = [
        OnboardingStep(
            title: "Welcome to WebCraft",
            description: "Learn HTML, CSS, and JavaScript through interactive lessons and earn XP as you progress!",
            icon: "sparkles",
            color: .appPrimary
        ),
        OnboardingStep(
            title: "Write Code",
            description: "Use our multi-language editor to write HTML, CSS, and JavaScript with syntax highlighting and smart completion.",
            icon: "laptopcomputer",
            color: .blue
        ),
        OnboardingStep(
            title: "See Live Preview",
            description: "Watch your code come to life instantly in the live preview panel as you type.",
            icon: "eye.fill",
            color: .appSuccess
        ),
        OnboardingStep(
            title: "Auto-Save & Hints",
            description: "Your code saves automatically, and you can get progressive hints if you're stuck.",
            icon: "lightbulb.fill",
            color: .appWarning
        ),
        OnboardingStep(
            title: "Learn & Level Up",
            description: "Complete lessons to earn XP, unlock badges, and level up your web development skills!",
            icon: "trophy.fill",
            color: .orange
        )
    ]
    
    var body: some View {
        ZStack {
            // Background
            Color.appBackground
                .ignoresSafeArea()
            
            // Subtle gradient overlay
            LinearGradient(
                colors: [currentStepData.color.opacity(0.2), Color.clear],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Icon
                Image(systemName: currentStepData.icon)
                    .font(.system(size: 80, weight: .light))
                    .foregroundColor(currentStepData.color)
                    .scaleEffect(scale)
                
                // Content
                VStack(spacing: 16) {
                    Text(currentStepData.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(currentStepData.description)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .opacity(opacity)
                
                Spacer()
                
                // Progress dots
                HStack(spacing: 8) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentStep ? currentStepData.color : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                
                // Navigation buttons
                HStack {
                    if currentStep > 0 {
                        Button("Back") {
                            previousStep()
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(currentStep == steps.count - 1 ? "Get Started" : "Next") {
                        if currentStep == steps.count - 1 {
                            completeOnboarding()
                        } else {
                            nextStep()
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(currentStepData.color)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
            
            // Skip button
            VStack {
                HStack {
                    Spacer()
                    Button("Skip") {
                        completeOnboarding()
                    }
                    .foregroundColor(.secondary)
                    .padding()
                }
                Spacer()
            }
        }
        .onAppear {
            animateIn()
        }
    }
    
    private var currentStepData: OnboardingStep {
        steps[currentStep]
    }
    
    private func animateIn() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            opacity = 1
            scale = 1
        }
    }
    
    private func nextStep() {
        HapticManager.shared.trigger(.light)
        withAnimation(.easeOut(duration: 0.2)) {
            opacity = 0
            scale = 0.9
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            currentStep += 1
            animateIn()
        }
    }
    
    private func previousStep() {
        HapticManager.shared.trigger(.light)
        withAnimation(.easeOut(duration: 0.2)) {
            opacity = 0
            scale = 1.1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            currentStep -= 1
            animateIn()
        }
    }
    
    private func completeOnboarding() {
        HapticManager.shared.trigger(.medium)
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        withAnimation(.easeOut(duration: 0.3)) {
            opacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onComplete()
        }
    }
}
