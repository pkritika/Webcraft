//
//  UserProgress.swift
//  WebCraft
//
//  Created on 2026-01-29.
//

import Foundation

struct UserProgress: Codable {
    var userName: String
    var avatarName: String
    var totalXP: Int
    var currentLevel: Int
    var completedLessonIds: Set<Int>
    var earnedBadges: Set<String>
    var currentStreak: Int
    var longestStreak: Int
    var lastActivityDate: Date?
    
    init(name: String = "Learner") {
        self.userName = name
        self.avatarName = "person.circle.fill"
        self.totalXP = 0
        self.currentLevel = 1
        self.completedLessonIds = []
        self.earnedBadges = []
        self.currentStreak = 0
        self.longestStreak = 0
        self.lastActivityDate = nil
    }
    
    mutating func addXP(_ amount: Int) {
        totalXP += amount
        updateLevel()
    }
    
    mutating func completeLesson(_ lessonId: Int) {
        completedLessonIds.insert(lessonId)
        updateActivity()
    }
    
    mutating func earnBadge(_ badgeId: String) {
        earnedBadges.insert(badgeId)
    }
    
    private mutating func updateLevel() {
        currentLevel = LevelCalculator.level(from: totalXP)
    }
    
    private mutating func updateActivity() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastDate = lastActivityDate {
            let lastDay = calendar.startOfDay(for: lastDate)
            let daysDifference = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            
            if daysDifference == 1 {
                // Consecutive day
                currentStreak += 1
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
            } else if daysDifference > 1 {
                // Streak broken
                currentStreak = 1
            }
            // Same day, do nothing
        } else {
            // First activity
            currentStreak = 1
            longestStreak = 1
        }
        
        lastActivityDate = Date()
    }
}
