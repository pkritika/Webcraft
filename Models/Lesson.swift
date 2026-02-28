//
//  Lesson.swift
//  WebCraft
//
//  Created on 2026-01-29.
//

import Foundation

struct Lesson: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let description: String
    let difficulty: Difficulty
    let xpReward: Int
    let prerequisiteId: Int? // nil for first lesson
    let moduleTitle: String // New: Grouping
    let isAssessment: Bool // New: Checkpoint
    let sections: [LessonSection]
    
    enum Difficulty: String, Codable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        
        var color: String {
            switch self {
            case .beginner: return "green"
            case .intermediate: return "orange"
            case .advanced: return "red"
            }
        }
    }
    
    // Custom initializer for backward compatibility
    init(id: Int, title: String, description: String, difficulty: Difficulty, xpReward: Int, prerequisiteId: Int?, moduleTitle: String = "Core Skills", isAssessment: Bool = false, sections: [LessonSection]) {
        self.id = id
        self.title = title
        self.description = description
        self.difficulty = difficulty
        self.xpReward = xpReward
        self.prerequisiteId = prerequisiteId
        self.moduleTitle = moduleTitle
        self.isAssessment = isAssessment
        self.sections = sections
    }
}

struct LessonSection: Codable, Hashable {
    let type: SectionType
    let title: String
    let content: String
    let codeExample: String?
    let challenge: Challenge?
    let quiz: Quiz? // New property for quiz data
    
    enum SectionType: String, Codable {
        case theory
        case example
        case practice
        case quiz // New type
    }
    
    // Custom initializer to handle optional quiz parameter for backward compatibility
    init(type: SectionType, title: String, content: String, codeExample: String? = nil, challenge: Challenge? = nil, quiz: Quiz? = nil) {
        self.type = type
        self.title = title
        self.content = content
        self.codeExample = codeExample
        self.challenge = challenge
        self.quiz = quiz
    }
}

struct Challenge: Codable, Hashable {
    let instruction: String
    let starterCode: String
    let starterCSS: String?
    let starterJS: String?
    let validationRules: [ValidationRule]
    let hint: String?
}

struct ValidationRule: Codable, Hashable {
    let type: ValidationType
    let value: String
    let message: String
    
    enum ValidationType: String, Codable {
        case containsTag       // Must contain specific HTML tag
        case containsAttribute // Must contain specific attribute
        case minimumTags       // Minimum number of a tag type
        case hasText           // Must contain specific text
    }
}

// New Quiz Model
struct Quiz: Codable, Hashable {
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String?
}
