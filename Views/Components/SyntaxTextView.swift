import SwiftUI
import UIKit

struct SyntaxTextView: UIViewRepresentable {
    @Binding var text: String
    let language: CodeLanguage

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        // Setup IDE-like appearance
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.monospacedSystemFont(ofSize: 15, weight: .regular)
        textView.textColor = UIColor(red: 226/255, green: 232/255, blue: 240/255, alpha: 1.0) // Slate 200
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        textView.keyboardType = .asciiCapable
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        // Prevent infinite loops if typing
        if uiView.text != text {
            uiView.attributedText = applyHighlighting(to: text, language: language)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: SyntaxTextView

        init(_ parent: SyntaxTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            // Update binding
            parent.text = textView.text

            // Reapply highlighting dynamically as user types
            // Store selected range to restore after AttributedText swap
            let selectedRange = textView.selectedRange
            textView.attributedText = parent.applyHighlighting(to: textView.text, language: parent.language)
            textView.selectedRange = selectedRange
        }
    }
    
    // MARK: - Highlight Logic
    
    // Helper to generate precise syntax colors similar to VS Code (Dark+)
    private func applyHighlighting(to code: String, language: CodeLanguage) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: code)
        let baseFont = UIFont.monospacedSystemFont(ofSize: 15, weight: .regular)
        let baseColor = UIColor(red: 226/255, green: 232/255, blue: 240/255, alpha: 1.0)
        
        // Apply base font and color entirely
        attributedString.addAttribute(.font, value: baseFont, range: NSRange(location: 0, length: code.utf16.count))
        attributedString.addAttribute(.foregroundColor, value: baseColor, range: NSRange(location: 0, length: code.utf16.count))
        
        let fullRange = NSRange(location: 0, length: code.utf16.count)

        func colorize(regex: String, color: UIColor) {
            if let regex = try? NSRegularExpression(pattern: regex, options: []) {
                let matches = regex.matches(in: code, options: [], range: fullRange)
                for match in matches {
                    attributedString.addAttribute(.foregroundColor, value: color, range: match.range)
                }
            }
        }
        
        // Colors
        let tagColor = UIColor(red: 86/255, green: 156/255, blue: 214/255, alpha: 1.0) // Blue
        let attrColor = UIColor(red: 156/255, green: 220/255, blue: 254/255, alpha: 1.0) // Light Blue
        let stringColor = UIColor(red: 206/255, green: 145/255, blue: 120/255, alpha: 1.0) // Orange/Brown
        let commentColor = UIColor(red: 106/255, green: 153/255, blue: 85/255, alpha: 1.0) // Green
        let keywordColor = UIColor(red: 197/255, green: 134/255, blue: 192/255, alpha: 1.0) // Purple
        let propertyColor = UIColor(red: 156/255, green: 220/255, blue: 254/255, alpha: 1.0) // Light Blue
        let valueColor = UIColor(red: 181/255, green: 206/255, blue: 168/255, alpha: 1.0) // Pale Green
        
        switch language {
        case .html:
            // HTML Tags: <tag>
            colorize(regex: "</?[a-zA-Z0-9]+", color: tagColor)
            colorize(regex: ">", color: tagColor)
            // HTML Attributes: attr=
            colorize(regex: "\\b[a-zA-Z\\-]+\\s*(?==)", color: attrColor)
            // Strings: "value"
            colorize(regex: "\"[^\"]*\"", color: stringColor)
            // Comments: <!-- comment -->
            colorize(regex: "<!--[\\s\\S]*?-->", color: commentColor)
            
        case .css:
            // Selectors: .class, #id, tag
            colorize(regex: "^[\\w\\.\\-#\\s,:]+(?=\\s*\\{)", color: tagColor)
            // Properties: prop:
            colorize(regex: "[a-zA-Z\\-]+(?=\\s*:)", color: propertyColor)
            // Values: : value;
            colorize(regex: "(?<=:)\\s*[^;]+", color: valueColor)
            // Strings: "value"
            colorize(regex: "\"[^\"]*\"", color: stringColor)
            // Comments: /* comment */
            colorize(regex: "/\\*[\\s\\S]*?\\*/", color: commentColor)
            
        case .javascript:
            // Keywords
            colorize(regex: "\\b(function|const|let|var|return|if|else|for|while|switch|case|break|class|import|export|from)\\b", color: keywordColor)
            // Strings
            colorize(regex: "(['\"`])[^\\'\"`]*\\1", color: stringColor)
            // Numbers
            colorize(regex: "\\b\\d+(\\.\\d+)?\\b", color: valueColor)
            // Comments: // or /* */
            colorize(regex: "//.*", color: commentColor)
            colorize(regex: "/\\*[\\s\\S]*?\\*/", color: commentColor)
        }
        
        return attributedString
    }
}
