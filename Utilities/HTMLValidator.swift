//
//  HTMLValidator.swift
//  WebCraft
//
//  Created on 2026-01-29.
//

import Foundation

struct HTMLValidator {
    static func validate(html: String, against rules: [ValidationRule]) -> ValidationResult {
        print("🔍 Validating HTML with \(rules.count) rules")
        print("📝 HTML Code: \(html.prefix(100))...")
        
        var errors: [String] = []
        
        // FIRST: Check for basic HTML syntax errors
        let syntaxErrors = validateHTMLSyntax(html)
        if !syntaxErrors.isEmpty {
            print("❌ Syntax errors found:")
            for error in syntaxErrors {
                print("  - \(error)")
                errors.append(error)
            }
            let result = ValidationResult(isValid: false, errors: errors)
            print("🎯 Validation result: INVALID ✗ (syntax errors)")
            return result
        }
        
        // THEN: Check validation rules
        for rule in rules {
            print("✓ Checking rule: \(rule.type) - \(rule.value)")
            switch rule.type {
            case .containsTag:
                if !containsTag(html, tag: rule.value) {
                    errors.append(rule.message)
                    print("❌ Failed: \(rule.message)")
                } else {
                    print("✅ Passed: Found tag <\(rule.value)>")
                }
            case .containsAttribute:
                if !containsAttribute(html, attribute: rule.value) {
                    errors.append(rule.message)
                    print("❌ Failed: \(rule.message)")
                } else {
                    print("✅ Passed: Found attribute \(rule.value)")
                }
            case .minimumTags:
                let parts = rule.value.split(separator: ":")
                if parts.count == 2,
                   let minCount = Int(parts[1]),
                   let tag = parts.first {
                    let count = countTags(html, tag: String(tag))
                    if count < minCount {
                        errors.append(rule.message)
                        print("❌ Failed: \(rule.message) (found \(count), need \(minCount))")
                    } else {
                        print("✅ Passed: Found \(count) <\(tag)> tags")
                    }
                }
            case .hasText:
                if !html.contains(rule.value) {
                    errors.append(rule.message)
                    print("❌ Failed: \(rule.message)")
                } else {
                    print("✅ Passed: Found text '\(rule.value)'")
                }
            }
        }
        
        let result = ValidationResult(isValid: errors.isEmpty, errors: errors)
        print("🎯 Validation result: \(result.isValid ? "VALID ✓" : "INVALID ✗") (\(errors.count) errors)")
        return result
    }
    
    // Validate basic HTML syntax
    private static func validateHTMLSyntax(_ html: String) -> [String] {
        var errors: [String] = []
        
        // Check for unclosed angle brackets
        let openBrackets = html.filter { $0 == "<" }.count
        let closeBrackets = html.filter { $0 == ">" }.count
        if openBrackets != closeBrackets {
            errors.append("Syntax error: Unclosed tag detected - check all < and > brackets")
            return errors // Return early for major syntax error
        }
        
        // Check for malformed closing tags (e.g., </p without >)
        let closingTagPattern = "</[a-zA-Z0-9]+(?!>)"
        if let regex = try? NSRegularExpression(pattern: closingTagPattern, options: []) {
            let range = NSRange(html.startIndex..., in: html)
            if regex.firstMatch(in: html, range: range) != nil {
                errors.append("Syntax error: Incomplete closing tag (missing '>' bracket)")
            }
        }
        
        // Check for malformed opening tags (e.g., <p without >)
        let lines = html.split(separator: "\n", omittingEmptySubsequences: false)
        for (index, line) in lines.enumerated() {
            let lineStr = String(line)
            // Skip empty lines and comments
            if lineStr.trimmingCharacters(in: .whitespaces).isEmpty || lineStr.contains("<!--") {
                continue
            }
            
            // Check if line has < but doesn't properly close before next <
            var inTag = false
            var lastOpenIndex = -1
            for (i, char) in lineStr.enumerated() {
                if char == "<" {
                    if inTag {
                        errors.append("Syntax error on line \(index + 1): Nested tag opening without closing previous tag")
                        break
                    }
                    inTag = true
                    lastOpenIndex = i
                } else if char == ">" {
                    inTag = false
                }
            }
            if inTag {
                errors.append("Syntax error on line \(index + 1): Tag opened with '<' but not closed with '>'")
            }
        }
        
        return errors
    }
    
    private static func containsTag(_ html: String, tag: String) -> Bool {
        let lowercasedHTML = html.lowercased()
        let lowercasedTag = tag.lowercased()
        
        // Check for self-closing tags (like <br/>, <img/>)
        let selfClosingPattern = "<\(lowercasedTag)[\\s/>]"
        let selfClosingRegex = try? NSRegularExpression(pattern: selfClosingPattern, options: [])
        let selfClosingMatches = selfClosingRegex?.matches(in: lowercasedHTML, range: NSRange(lowercasedHTML.startIndex..., in: lowercasedHTML))
        
        // For self-closing tags, just check if they exist properly
        let isSelfClosing = ["img", "br", "hr", "input", "meta", "link"].contains(lowercasedTag)
        if isSelfClosing {
            return (selfClosingMatches?.count ?? 0) > 0
        }
        
        // For regular tags, check for BOTH opening and closing tags
        let openingTag = "<\(lowercasedTag)"
        let closingTag = "</\(lowercasedTag)>"
        
        let hasOpening = lowercasedHTML.contains(openingTag) && 
                        (lowercasedHTML.contains("\(openingTag)>") || 
                         lowercasedHTML.contains("\(openingTag) "))
        let hasClosing = lowercasedHTML.contains(closingTag)
        
        print("  → Checking <\(tag)>: opening=\(hasOpening), closing=\(hasClosing)")
        return hasOpening && hasClosing
    }
    
    private static func containsAttribute(_ html: String, attribute: String) -> Bool {
        return html.lowercased().contains(attribute.lowercased())
    }
    
    private static func countTags(_ html: String, tag: String) -> Int {
        let pattern = "<\(tag)[\\s>]"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let matches = regex?.matches(in: html, range: NSRange(html.startIndex..., in: html))
        return matches?.count ?? 0
    }
}

struct ValidationResult {
    let isValid: Bool
    let errors: [String]
}
