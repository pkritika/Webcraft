import SwiftUI
struct ProfileView: View {
    @EnvironmentObject var progressService: ProgressService
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Custom Header
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //.padding(.top) // keeping standard padding
                    
                    Image(systemName: progressService.userProgress.avatarName)
                        .font(.system(size: 80))
                        .foregroundColor(.appPrimary)
                    
                    Text(progressService.userProgress.userName)
                        .font(.title)
                        .bold()
                        .foregroundColor(.textPrimary)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("\(progressService.userProgress.currentLevel)")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.textPrimary)
                            Text("Level")
                                .foregroundColor(.textSecondary)
                        }
                        
                        VStack {
                            Text("\(progressService.userProgress.totalXP)")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.textPrimary)
                            Text("Total XP")
                                .foregroundColor(.textSecondary)
                        }
                    }
                    .padding()
                    
                    Text("Badges")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.textPrimary)
                        .padding()
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(Badge.allBadges, id: \.id) { badge in
                            BadgeCard(badge: badge, isUnlocked: progressService.userProgress.earnedBadges.contains(badge.id))
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        LocalAuthService.shared.signOut()
                    }) {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview("Profile") {
    ProfileView()
        .environmentObject(ProgressService.shared)
}
