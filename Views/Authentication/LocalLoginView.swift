import SwiftUI

struct LocalLoginView: View {
    @EnvironmentObject var authService: LocalAuthService
    @State private var name = ""
    @State private var password = ""
    @State private var isSignUp = true
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Logo
                VStack(spacing: 12) {
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundColor(.appPrimary)

                    Text("WebCraft")
                        .font(.system(size: 38, weight: .heavy))
                        .foregroundColor(.textPrimary)

                    Text("Learn to build websites")
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                }

                // Form card
                VStack(spacing: 16) {
                    Text(isSignUp ? "Create Account" : "Welcome Back")
                        .font(.title2.bold())
                        .foregroundColor(.textPrimary)

                    VStack(spacing: 12) {
                        TextField("Your name", text: $name)
                            .textFieldStyle(.plain)
                            .padding(14)
                            .background(Color.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .foregroundColor(.textPrimary)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)

                        SecureField("Password (4+ chars)", text: $password)
                            .textFieldStyle(.plain)
                            .padding(14)
                            .background(Color.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .foregroundColor(.textPrimary)
                    }

                    if let error = authService.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button {
                        isLoading = true
                        if isSignUp {
                            _ = authService.signUp(name: name, password: password)
                        } else {
                            _ = authService.signIn(name: name, password: password)
                        }
                        isLoading = false
                    } label: {
                        Group {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.black)
                            } else {
                                Text(isSignUp ? "Start Learning →" : "Sign In →")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.appPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    Button {
                        isSignUp.toggle()
                        authService.errorMessage = nil
                    } label: {
                        Text(isSignUp ? "Already have an account? Sign in" : "New here? Create account")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                }
                .padding(24)
                .background(Color.cardBackground.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)

                Spacer()
            }
        }
    }
}
