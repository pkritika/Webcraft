//
//  LevelCalculator.swift
//  WebCraft
//
//  Created on 2026-01-29.
//

import Foundation

struct LevelCalculator {
    // XP required increases progressively: Level 2 = 100, Level 3 = 250, etc.
    static func level(from xp: Int) -> Int {
        var currentLevel = 1
        var xpNeeded = 0
        
        while xp >= xpNeeded {
            currentLevel += 1
            xpNeeded += xpForNextLevel(currentLevel)
        }
        
        return currentLevel - 1
    }
    
    static func xpForNextLevel(_ level: Int) -> Int {
        // Progressive XP requirements
        return 100 * level
    }
    
    static func xpToNextLevel(currentXP: Int, currentLevel: Int) -> Int {
        let totalXPForNextLevel = totalXPForLevel(currentLevel + 1)
        return totalXPForNextLevel - currentXP
    }
    
    static func totalXPForLevel(_ level: Int) -> Int {
        guard level > 1 else {
            return 0 // Level 1 requires 0 XP to achieve
        }
        var total = 0
        for lvl in 2...level {
            total += xpForNextLevel(lvl)
        }
        return total
    }
    
    static func progressToNextLevel(currentXP: Int, currentLevel: Int) -> Double {
        let totalXPForCurrentLevel = totalXPForLevel(currentLevel)
        let totalXPForNextLevel = totalXPForLevel(currentLevel + 1)
        let xpInCurrentLevel = currentXP - totalXPForCurrentLevel
        let xpNeededForLevel = totalXPForNextLevel - totalXPForCurrentLevel
        
        guard xpNeededForLevel > 0 else {
            return 0.0
        }
        
        let progress = Double(xpInCurrentLevel) / Double(xpNeededForLevel)
        return max(0.0, min(1.0, progress)) // Clamp between 0 and 1
    }
}
