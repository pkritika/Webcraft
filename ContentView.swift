//
//  ContentView.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var progressService: ProgressService
    @EnvironmentObject var portfolioService: PortfolioService
    @State private var selectedTab = 0
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    @State private var showWelcome = !UserDefaults.standard.bool(forKey: "hasSeenWelcome")

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                CourseworkListView()
                    .tabItem {
                        Label("Coursework", systemImage: "book.fill")
                    }
                    .tag(1)
                
                AssessmentListView()
                    .tabItem {
                        Label("Assessment", systemImage: "checkmark.seal.fill")
                    }
                    .tag(2)
                
                MyPortfolioView()
                    .tabItem {
                        Label("My Portfolio", systemImage: "person.crop.square.filled.and.at.rectangle")
                    }
                    .tag(3)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(4)
            }
            .accentColor(.appPrimary)
            .background(Color.appBackground.ignoresSafeArea())
            .onChange(of: selectedTab) { _ in
                HapticManager.shared.trigger(.selection)
            }
            
            // Celebration overlay
            if progressService.showCelebration, let celebration = progressService.celebrationType {
                CelebrationOverlay(type: celebration) {
                    progressService.showCelebration = false
                }
                .transition(.opacity)
                .zIndex(999)
            }
            
            
            // Onboarding overlay (renders behind welcome so there's no flash)
            if showOnboarding {
                OnboardingView {
                    showOnboarding = false
                    
                    // Show welcome celebration after onboarding
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        progressService.celebrationType = .lessonComplete(xp: 0, lessonTitle: "Welcome to WebCraft!")
                        progressService.showCelebration = true
                    }
                }
                .transition(.opacity)
                .zIndex(1000)
            }
            
            // Welcome screen overlay (on top of onboarding)
            if showWelcome {
                WelcomeView(showWelcome: $showWelcome)
                    .zIndex(1001)
                    .onDisappear {
                        UserDefaults.standard.set(true, forKey: "hasSeenWelcome")
                    }
            }
        }
        .environmentObject(progressService)
        .environmentObject(portfolioService)
    }
}

#Preview {
    ContentView()
}
