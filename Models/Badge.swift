//
//  Badge.swift
//  WebCraft
//
//  Created on 2026-01-29.
//

import Foundation

struct Badge: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let icon: String // SF Symbol name
    let rarity: Rarity
    let unlockCondition: UnlockCondition
    
    enum Rarity: String, Hashable {
        case common = "Common"
        case rare = "Rare"
        case epic = "Epic"
        case legendary = "Legendary"
        
        var color: String {
            switch self {
            case .common: return "gray"
            case .rare: return "blue"
            case .epic: return "purple"
            case .legendary: return "yellow"
            }
        }
    }
    
    enum UnlockCondition: Hashable {
        case completeLessons(count: Int)
        case reachLevel(level: Int)
        case earnXP(amount: Int)
        case completeStreak(days: Int)
        case completeAllLessons
    }
    
    func isUnlocked(progress: UserProgress) -> Bool {
        switch unlockCondition {
        case .completeLessons(let count):
            return progress.completedLessonIds.count >= count
        case .reachLevel(let level):
            return progress.currentLevel >= level
        case .earnXP(let amount):
            return progress.totalXP >= amount
        case .completeStreak(let days):
            return progress.currentStreak >= days
        case .completeAllLessons:
            return progress.completedLessonIds.count >= LessonContent.allLessons.count
        }
    }
    
    static let allBadges: [Badge] = [
        Badge(
            id: "first_steps",
            title: "First Steps",
            description: "Complete your first lesson",
            icon: "star.fill",
            rarity: .common,
            unlockCondition: .completeLessons(count: 1)
        ),
        Badge(
            id: "html_novice",
            title: "HTML Novice",
            description: "Complete 5 lessons",
            icon: "doc.text.fill",
            rarity: .rare,
            unlockCondition: .completeLessons(count: 5)
        ),
        Badge(
            id: "web_master",
            title: "Web Master",
            description: "Complete all lessons",
            icon: "crown.fill",
            rarity: .legendary,
            unlockCondition: .completeAllLessons
        ),
        Badge(
            id: "level_5",
            title: "Rising Star",
            description: "Reach level 5",
            icon: "sparkles",
            rarity: .rare,
            unlockCondition: .reachLevel(level: 5)
        ),
        Badge(
            id: "streak_master",
            title: "Streak Master",
            description: "Maintain a 7-day streak",
            icon: "flame.fill",
            rarity: .epic,
            unlockCondition: .completeStreak(days: 7)
        )
    ]
}
