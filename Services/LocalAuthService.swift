import Foundation
import SwiftUI

/// Local-only auth service — no Firebase, no network.
/// Stores credentials in UserDefaults for offline use.
@MainActor
class LocalAuthService: ObservableObject {
    static let shared = LocalAuthService()

    @Published var isAuthenticated: Bool = false
    @Published var userName: String = ""
    @Published var errorMessage: String?

    private let authKey = "localAuth_isAuthenticated"
    private let nameKey = "localAuth_userName"

    private init() {
        isAuthenticated = UserDefaults.standard.bool(forKey: authKey)
        userName = UserDefaults.standard.string(forKey: nameKey) ?? ""
    }

    /// Create a new account — stores name locally, marks as authenticated.
    func signUp(name: String, password: String) -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter your name."
            return false
        }
        guard password.count >= 4 else {
            errorMessage = "Password must be at least 4 characters."
            return false
        }
        // Store hashed password (basic — suitable for offline toy auth)
        let hashedPassword = String(password.hashValue)
        UserDefaults.standard.set(hashedPassword, forKey: "localAuth_password")
        UserDefaults.standard.set(name, forKey: nameKey)
        UserDefaults.standard.set(true, forKey: authKey)

        self.userName = name
        self.isAuthenticated = true
        self.errorMessage = nil

        ProgressService.shared.updateUserName(name)
        return true
    }

    /// Sign in — checks stored password.
    func signIn(name: String, password: String) -> Bool {
        let storedHash = UserDefaults.standard.string(forKey: "localAuth_password")
        let enteredHash = String(password.hashValue)

        guard storedHash == enteredHash else {
            errorMessage = "Incorrect password. Try again."
            return false
        }

        let storedName = UserDefaults.standard.string(forKey: nameKey) ?? name
        UserDefaults.standard.set(true, forKey: authKey)
        self.userName = storedName
        self.isAuthenticated = true
        self.errorMessage = nil
        return true
    }

    func signOut() {
        UserDefaults.standard.set(false, forKey: authKey)
        self.isAuthenticated = false
        ProgressService.shared.resetProgress()
        CodeStorageService.shared.clearAll()
        PortfolioService.shared.resetPortfolio()
        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
        UserDefaults.standard.removeObject(forKey: "hasSeenWelcome")
    }
    
    // Compatibility shim so views that reference .user?.uid still compile
    var user: LocalUser? {
        isAuthenticated ? LocalUser(name: userName) : nil
    }
}

struct LocalUser {
    let name: String
    // uid is just the name for local storage keying
    var uid: String { name }
}
