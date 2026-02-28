import Foundation
import SwiftUI
import Combine

@MainActor
class ProgressService: ObservableObject {
    static let shared = ProgressService()

    @Published var userProgress: UserProgress {
        didSet { saveProgress() }
    }

    @Published var newlyEarnedBadges: [Badge] = []
    @Published var showBadgeCelebration = false
    @Published var didLevelUp = false
    @Published var previousLevel = 1

    // Celebration system
    @Published var showCelebration = false
    @Published var celebrationType: CelebrationType?

    private let progressKey = "userProgress"

    // Bump this whenever lesson IDs change (module restructures, additions, etc.)
    private let curriculumVersion = 8
    private let curriculumVersionKey = "curriculumVersion"

    private init() {
        let savedVersion = UserDefaults.standard.integer(forKey: curriculumVersionKey)
        if savedVersion < curriculumVersion {
            // Curriculum structure changed — wipe stale progress so no wrong lessons unlock
            UserDefaults.standard.removeObject(forKey: "userProgress")
            UserDefaults.standard.set(curriculumVersion, forKey: curriculumVersionKey)
            self.userProgress = UserProgress()
        } else if let data = UserDefaults.standard.data(forKey: progressKey),
           let decoded = try? JSONDecoder().decode(UserProgress.self, from: data) {
            self.userProgress = decoded
        } else {
            self.userProgress = UserProgress()
        }
        self.previousLevel = userProgress.currentLevel
    }

    func saveProgress() {
        if let encoded = try? JSONEncoder().encode(userProgress) {
            UserDefaults.standard.set(encoded, forKey: progressKey)
        }
    }

    func completeLesson(_ lesson: Lesson) {
        let oldLevel = userProgress.currentLevel

        userProgress.completeLesson(lesson.id)
        userProgress.addXP(lesson.xpReward)

        HapticManager.shared.triggerCelebration()

        celebrationType = .lessonComplete(xp: lesson.xpReward, lessonTitle: lesson.title)
        showCelebration = true

        if userProgress.currentLevel > oldLevel {
            previousLevel = oldLevel
            didLevelUp = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.celebrationType = .levelUp(oldLevel: oldLevel, newLevel: self.userProgress.currentLevel)
                self.showCelebration = true
            }
        }

        checkForNewBadges()
    }

    func checkForNewBadges() {
        var newBadges: [Badge] = []
        for badge in Badge.allBadges {
            if badge.isUnlocked(progress: userProgress) &&
                !userProgress.earnedBadges.contains(badge.id) {
                userProgress.earnBadge(badge.id)
                newBadges.append(badge)
            }
        }
        if !newBadges.isEmpty {
            newlyEarnedBadges = newBadges
            showBadgeCelebration = true
            if let firstBadge = newBadges.first {
                HapticManager.shared.trigger(.success)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.celebrationType = .badgeUnlocked(badge: firstBadge)
                    self.showCelebration = true
                }
            }
        }
    }

    func resetProgress() {
        userProgress = UserProgress()
        UserDefaults.standard.removeObject(forKey: progressKey)
    }

    func isLessonUnlocked(_ lesson: Lesson) -> Bool {
        // TEMPORARY: Unlock all lessons for review
        return true
    }

    func isLessonCompleted(_ lesson: Lesson) -> Bool {
        return userProgress.completedLessonIds.contains(lesson.id)
    }

    func updateUserName(_ name: String) {
        userProgress.userName = name
        saveProgress()
    }
}
