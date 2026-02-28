//
//  HintSystem.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import Foundation

enum HintLevel: Int {
    case none = 0
    case subtle = 1
    case basic = 2
    case detailed = 3
    case solution = 4
}

struct Hint {
    let level: HintLevel
    let text: String
    let code: String?
}

class HintSystem {
    static func getHints(for challenge: Challenge) -> [Hint] {
        var hints: [Hint] = []
        
        // Subtle hint
        hints.append(Hint(
            level: .subtle,
            text: "💡 Need help? Tap for a hint",
            code: nil
        ))
        
        // Basic hint from challenge hint field
        if let basicHint = challenge.hint {
            hints.append(Hint(
                level: .basic,
                text: basicHint,
                code: nil
            ))
        }
        
        // Detailed hint with code example
        hints.append(Hint(
            level: .detailed,
            text: "Here's an example you can use:",
            code: challenge.hint
        ))
        
        // Solution - show starter code
        hints.append(Hint(
            level: .solution,
            text: "Complete solution:",
            code: generateSolutionHint(for: challenge)
        ))
        
        return hints
    }
    
    private static func generateSolutionHint(for challenge: Challenge) -> String {
        // Generate a working solution based on validation rules
        var solution = challenge.starterCode
        
        for rule in challenge.validationRules {
            switch rule.type {
            case .containsTag:
                if !solution.contains("<\(rule.value)") {
                    solution += "\n<\(rule.value)>Content</\(rule.value)>"
                }
            default:
                break
            }
        }
        
        return solution
    }
}
