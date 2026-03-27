import SwiftUI

@main
struct MyApp: App {
    @StateObject private var progressService = ProgressService.shared
    @StateObject private var portfolioService = PortfolioService.shared
    @StateObject private var authService = LocalAuthService.shared

    init() {
        // Configure navigation bar appearance globally for dark theme
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.appBackground)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                ContentView()
                    .environmentObject(progressService)
                    .environmentObject(portfolioService)
                    .environmentObject(authService)
            } else {
                LocalLoginView()
                    .environmentObject(authService)
            }
        }
    }
}

