//
//  CodeCompletionEngine.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import Foundation

@MainActor
class CodeCompletionEngine {
    static let shared = CodeCompletionEngine()
    
    private init() {}
    
    // HTML Code Snippets
    let htmlSnippets: [String: String] = [
        "html5": """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Page Title</title>
        </head>
        <body>
            
        </body>
        </html>
        """,
        "div": "<div></div>",
        "button": "<button></button>",
        "link": "<a href=\"\"></a>",
        "img": "<img src=\"\" alt=\"\">",
        "input": "<input type=\"text\">",
        "p": "<p></p>",
        "h1": "<h1></h1>",
        "ul": "<ul>\n    <li></li>\n</ul>",
        "table": "<table>\n    <tr>\n        <td></td>\n    </tr>\n</table>"
    ]
    
    // CSS Code Snippets
    let cssSnippets: [String: String] = [
        "flex": "display: flex;\njustify-content: center;\nalign-items: center;",
        "grid": "display: grid;\ngrid-template-columns: repeat(3, 1fr);\ngap: 10px;",
        "center": "margin: 0 auto;\ntext-align: center;",
        "shadow": "box-shadow: 0 2px 4px rgba(0,0,0,0.1);",
        "transition": "transition: all 0.3s ease;",
        "gradient": "background: linear-gradient(to right, #667eea, #764ba2);"
    ]
    
    // JavaScript Code Snippets
    let jsSnippets: [String: String] = [
        "func": "function functionName() {\n    \n}",
        "arrow": "const functionName = () => {\n    \n};",
        "log": "console.log();",
        "if": "if (condition) {\n    \n}",
        "for": "for (let i = 0; i < length; i++) {\n    \n}",
        "click": "element.addEventListener('click', () => {\n    \n});",
        "get": "document.getElementById('')",
        "query": "document.querySelector('')"
    ]
    
    // Auto-close HTML tags
    func autoCloseTag(for text: String, at position: Int) -> (text: String, cursorOffset: Int)? {
        // Simple tag detection: check for opening tag without closing
        let pattern = "<([a-zA-Z][a-zA-Z0-9]*)(?:[^>]*)>$"
        
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: text, range: NSRange(location: 0, length: text.count)),
              let tagRange = Range(match.range(at: 1), in: text) else {
            return nil
        }
        
        let tagName = String(text[tagRange])
        
        // Don't auto-close self-closing tags
        let selfClosingTags = ["img", "input", "br", "hr", "meta", "link"]
        guard !selfClosingTags.contains(tagName.lowercased()) else {
            return nil
        }
        
        let closingTag = "</\(tagName)>"
        return (text + closingTag, closingTag.count)
    }
    
    // Auto-pair brackets and quotes
    func autoPair(for character: Character) -> String? {
        switch character {
        case "(": return ")"
        case "[": return "]"
        case "{": return "}"
        case "\"": return "\""
        case "'": return "'"
        default: return nil
        }
    }
    
    // Get snippet for keyword
    func getSnippet(for keyword: String, language: CodeLanguage) -> String? {
        switch language {
        case .html:
            return htmlSnippets[keyword.lowercased()]
        case .css:
            return cssSnippets[keyword.lowercased()]
        case .javascript:
            return jsSnippets[keyword.lowercased()]
        }
    }
    
    // CSS property suggestions
    func cssSuggestions(for partial: String) -> [String] {
        let allProperties = [
            "color", "background", "background-color", "border", "border-radius",
            "padding", "margin", "width", "height", "display", "position",
            "font-size", "font-family", "font-weight", "text-align", "flex",
            "grid", "justify-content", "align-items", "opacity", "transition"
        ]
        
        return allProperties.filter { $0.hasPrefix(partial.lowercased()) }
    }
}
