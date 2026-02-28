//
//  AnimatedSectionView.swift
//  WebCraft
//
//  Interactive lesson section renderer — parses structured content into rich UI cards
//

import SwiftUI

// MARK: - Main View

struct AnimatedSectionView: View {
    let section: LessonSection
    @State private var appearedCards: Set<Int> = []
    @State private var expandedCode = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Header card
                sectionHeader
                    .appear(index: 0, appearedCards: appearedCards)
                    .onAppear { scheduleAppear(0) }

                // Parsed content blocks
                let blocks = ContentParser.parse(section.content)
                ForEach(Array(blocks.enumerated()), id: \.offset) { idx, block in
                    blockView(for: block)
                        .appear(index: idx + 1, appearedCards: appearedCards)
                        .onAppear { scheduleAppear(idx + 1) }
                }

                // Code example card
                if let code = section.codeExample {
                    codeExampleCard(code: code)
                        .appear(index: blocks.count + 2, appearedCards: appearedCards)
                        .onAppear { scheduleAppear(blocks.count + 2) }
                }

                Spacer(minLength: 40)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .background(Color.clear)
    }

    // MARK: - Section Header

    private var sectionHeader: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.2))
                    .frame(width: 56, height: 56)
                Image(systemName: sectionIcon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(accentColor)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(sectionTypeLabel.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(accentColor)
                    .tracking(1.5)
                Text(section.title)
                    .fontRounded(size: 22, weight: .bold)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(accentColor.opacity(0.3), lineWidth: 1)
                )
        )
    }

    // MARK: - Block Renderer

    @ViewBuilder
    private func blockView(for block: ContentBlock) -> some View {
        switch block {
        case .paragraph(let text):
            ParagraphCard(text: text, accentColor: accentColor)

        case .numberedSteps(let steps):
            NumberedStepsCard(steps: steps, accentColor: accentColor)

        case .bulletList(let items):
            BulletListCard(items: items, accentColor: accentColor)

        case .termList(let terms):
            TermGlossaryCard(terms: terms, accentColor: accentColor)

        case .callout(let emoji, let title, let body):
            CalloutCard(emoji: emoji, title: title, message: body, accentColor: accentColor)

        case .inlineCode(let code):
            InlineCodeCard(code: code, accentColor: accentColor)

        case .sectionHeader(let emoji, let title):
            SectionDividerView(emoji: emoji, title: title, accentColor: accentColor)
        }
    }

    // MARK: - Code Example Card

    private func codeExampleCard(code: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "chevron.left.forwardslash.chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(accentColor)
                Text("Example")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Button {
                    withAnimation(.spring(response: 0.3)) { expandedCode.toggle() }
                } label: {
                    Text(expandedCode ? "Collapse" : "Expand")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(accentColor)
                }
            }

            // Traffic light dots
            HStack(spacing: 6) {
                ForEach([Color(hex: "FF5F57"), Color(hex: "FEBC2E"), Color(hex: "28C840")], id: \.self) { c in
                    Circle().fill(c).frame(width: 10, height: 10)
                }
                Spacer()
            }

            let displayedCode = expandedCode ? code : String(code.prefix(300)) + (code.count > 300 ? "\n..." : "")
            ScrollView(.horizontal, showsIndicators: false) {
                Text(displayedCode)
                    .font(.system(size: 13, design: .monospaced))
                    .foregroundColor(Color(hex: "E2E8F0"))
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(hex: "0D1117"))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(accentColor.opacity(0.25), lineWidth: 1)
                )
        )
    }

    // MARK: - Helpers

    private func scheduleAppear(_ index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.08) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                _ = appearedCards.insert(index)
            }
        }
    }

    private var accentColor: Color {
        switch section.type {
        case .theory:   return Color(hex: "818CF8")
        case .example:  return Color(hex: "F472B6")
        case .practice: return Color(hex: "22D3EE")
        case .quiz:     return Color(hex: "FBBF24")
        }
    }

    private var sectionIcon: String {
        switch section.type {
        case .theory:   return "book.fill"
        case .example:  return "lightbulb.fill"
        case .practice: return "pencil.line"
        case .quiz:     return "checkmark.circle.fill"
        }
    }

    private var sectionTypeLabel: String {
        switch section.type {
        case .theory:   return "Theory"
        case .example:  return "Example"
        case .practice: return "Practice"
        case .quiz:     return "Quiz"
        }
    }
}

// MARK: - Appear Modifier

private extension View {
    func appear(index: Int, appearedCards: Set<Int>) -> some View {
        self
            .opacity(appearedCards.contains(index) ? 1 : 0)
            .offset(y: appearedCards.contains(index) ? 0 : 16)
    }
}

// MARK: - Content Blocks

enum ContentBlock {
    case sectionHeader(emoji: String, title: String)
    case paragraph(String)
    case numberedSteps([String])
    case bulletList([String])
    case termList([(term: String, definition: String)])
    case callout(emoji: String, title: String, body: String)
    case inlineCode(String)
}

// MARK: - Content Parser

struct ContentParser {
    static func parse(_ raw: String) -> [ContentBlock] {
        var blocks: [ContentBlock] = []
        let lines = raw.components(separatedBy: "\n").map { $0.trimmingCharacters(in: .whitespaces) }

        var i = 0
        var pendingParagraph: [String] = []
        var numberedSteps: [String] = []
        var bulletItems: [String] = []
        var termPairs: [(term: String, definition: String)] = []
        var inCodeFence = false
        var codeFenceLines: [String] = []

        func flushParagraph() {
            let text = pendingParagraph.joined(separator: " ").trimmingCharacters(in: .whitespaces)
            if !text.isEmpty { blocks.append(.paragraph(text)) }
            pendingParagraph = []
        }
        func flushNumbered() {
            if !numberedSteps.isEmpty { blocks.append(.numberedSteps(numberedSteps)); numberedSteps = [] }
        }
        func flushBullets() {
            if !bulletItems.isEmpty { blocks.append(.bulletList(bulletItems)); bulletItems = [] }
        }
        func flushTerms() {
            if !termPairs.isEmpty { blocks.append(.termList(termPairs)); termPairs = [] }
        }
        func flushCode() {
            let joined = codeFenceLines.joined(separator: "\n")
            if !joined.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                blocks.append(.inlineCode(joined))
            }
            codeFenceLines = []
        }

        while i < lines.count {
            let line = lines[i]

            // ── Code fence ──────────────────────────────────
            if line.hasPrefix("```") {
                if inCodeFence {
                    inCodeFence = false
                    flushCode()
                } else {
                    flushParagraph(); flushNumbered(); flushBullets(); flushTerms()
                    inCodeFence = true
                }
                i += 1; continue
            }
            if inCodeFence { codeFenceLines.append(line); i += 1; continue }

            // ── Empty line ───────────────────────────────────
            if line.isEmpty {
                flushParagraph(); flushNumbered(); flushBullets(); flushTerms()
                i += 1; continue
            }

            // ── Section header with emoji (1️⃣, 2️⃣, 🔑, 💡, 📝, ⚡, 🏗️, 🎮) ──
            if isEmojiHeader(line) {
                flushParagraph(); flushNumbered(); flushBullets(); flushTerms()
                let (emoji, title) = splitEmojiHeader(line)
                blocks.append(.sectionHeader(emoji: emoji, title: title))
                i += 1; continue
            }

            // ── Callout line starting with 💡 / 🔑 / 📌 / 🎮 ──
            if isCalloutLine(line) {
                flushParagraph(); flushNumbered(); flushBullets(); flushTerms()
                // Collect following lines as callout body until empty
                var calloutLines: [String] = []
                i += 1
                while i < lines.count && !lines[i].isEmpty && !isEmojiHeader(lines[i]) {
                    calloutLines.append(lines[i])
                    i += 1
                }
                let (emoji, rest) = firstEmoji(line)
                let body = calloutLines.isEmpty ? rest : (rest.isEmpty ? calloutLines.joined(separator: "\n") : rest + "\n" + calloutLines.joined(separator: "\n"))
                blocks.append(.callout(emoji: emoji, title: "", body: body))
                continue
            }

            // ── Numbered step: "1." / "1️⃣" ────────────────
            if let step = extractNumberedStep(line) {
                flushParagraph(); flushBullets(); flushTerms()
                numberedSteps.append(step)
                i += 1; continue
            }

            // ── Bullet / bullet with bold term ──────────────
            if line.hasPrefix("• ") || line.hasPrefix("- ") {
                let content = line.dropFirst(2).trimmingCharacters(in: .whitespaces)
                // Term definition? "**Term** — definition" or "**Term** — definition"
                if let termDef = extractTermDef(content) {
                    flushParagraph(); flushNumbered(); flushBullets()
                    termPairs.append(termDef)
                } else {
                    flushParagraph(); flushNumbered(); flushTerms()
                    bulletItems.append(content)
                }
                i += 1; continue
            }

            // ── Term def on its own line "**Term** — def" ──
            if line.hasPrefix("**") {
                if let termDef = extractTermDef(line) {
                    flushParagraph(); flushNumbered(); flushBullets()
                    termPairs.append(termDef)
                    i += 1; continue
                }
            }

            // ── Plain paragraph text ─────────────────────────
            flushNumbered(); flushBullets(); flushTerms()
            pendingParagraph.append(line)
            i += 1
        }

        flushParagraph(); flushNumbered(); flushBullets(); flushTerms()
        if inCodeFence { flushCode() }

        return blocks
    }

    // Helpers
    private static func isEmojiHeader(_ line: String) -> Bool {
        let prefixes = ["1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "🧠", "⚡", "🏗️", "📝", "🎮", "🔑"]
        return prefixes.contains(where: { line.hasPrefix($0) })
    }

    private static func isCalloutLine(_ line: String) -> Bool {
        let prefixes = ["💡", "📌", "🎯"]
        return prefixes.contains(where: { line.hasPrefix($0) })
    }

    private static func splitEmojiHeader(_ line: String) -> (String, String) {
        let multiEmojiPrefixes = ["1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "🧠", "⚡", "🏗️", "📝", "🎮", "🔑"]
        for prefix in multiEmojiPrefixes {
            if line.hasPrefix(prefix) {
                let rest = line.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
                return (prefix, rest)
            }
        }
        // fallback: first char is emoji
        let first = String(line.prefix(2))
        let rest = line.dropFirst(2).trimmingCharacters(in: .whitespaces)
        return (first, rest)
    }

    private static func firstEmoji(_ line: String) -> (emoji: String, rest: String) {
        let singleEmojiPrefixes = ["💡", "📌", "🎯", "🔑"]
        for prefix in singleEmojiPrefixes {
            if line.hasPrefix(prefix) {
                let rest = line.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
                return (prefix, rest)
            }
        }
        return ("ℹ️", line)
    }

    private static func extractNumberedStep(_ line: String) -> String? {
        // "1." or "2." at start
        let digitPrefixes = ["1.", "2.", "3.", "4.", "5.", "6.", "7.", "8.", "9."]
        for prefix in digitPrefixes {
            if line.hasPrefix(prefix) {
                return line.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
            }
        }
        // "1️⃣ **STEP**" style numbered
        let emojiDigits = ["1️⃣", "2️⃣", "3️⃣", "4️⃣"]
        for prefix in emojiDigits {
            if line.hasPrefix(prefix) {
                return line.dropFirst(prefix.count).trimmingCharacters(in: .whitespaces)
            }
        }
        return nil
    }

    private static func extractTermDef(_ text: String) -> (term: String, definition: String)? {
        // "**Term** — definition" or "**Term** - definition"
        guard text.hasPrefix("**") else { return nil }
        let stripped = text.dropFirst(2)
        guard let endBold = stripped.range(of: "**") else { return nil }
        let term = String(stripped[..<endBold.lowerBound])
        let afterBold = String(stripped[endBold.upperBound...]).trimmingCharacters(in: .whitespaces)
        let separators = [" — ", " — ", " - ", ": "]
        for sep in separators {
            if afterBold.hasPrefix(sep) {
                let definition = afterBold.dropFirst(sep.count).trimmingCharacters(in: .whitespaces)
                return (term, definition)
            }
        }
        // If no separator but there's text after the bold, treat remaining as definition
        if !afterBold.isEmpty {
            return (term, afterBold)
        }
        return nil
    }
}

// MARK: - Card Views

struct ParagraphCard: View {
    let text: String
    let accentColor: Color

    var body: some View {
        Text(styledText(text))
            .font(.system(size: 15))
            .foregroundColor(.white.opacity(0.85))
            .lineSpacing(5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func styledText(_ raw: String) -> AttributedString {
        // Strip markdown bold markers and return plain attributed string
        let plain = raw
            .replacingOccurrences(of: "**", with: "")
            .replacingOccurrences(of: "`", with: "")
        return AttributedString(plain)
    }
}

struct NumberedStepsCard: View {
    let steps: [String]
    let accentColor: Color
    @State private var visibleStep = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.offset) { idx, step in
                HStack(alignment: .top, spacing: 14) {
                    // Step number circle
                    ZStack {
                        Circle()
                            .fill(idx < visibleStep ? accentColor : accentColor.opacity(0.2))
                            .frame(width: 30, height: 30)
                        Text("\(idx + 1)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(idx < visibleStep ? .black : accentColor)
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            visibleStep = visibleStep == idx + 1 ? idx : idx + 1
                        }
                    }

                    // Connector line + text
                    VStack(alignment: .leading, spacing: 0) {
                        Text(cleanText(step))
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(4)
                            .padding(.top, 6)
                            .padding(.bottom, idx < steps.count - 1 ? 16 : 8)

                        if idx < steps.count - 1 {
                            Rectangle()
                                .fill(accentColor.opacity(0.2))
                                .frame(width: 1, height: 0)
                                .offset(x: -22)
                        }
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring()) {
                        visibleStep = idx + 1
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.05))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(accentColor.opacity(0.2), lineWidth: 1))
        )
        .onAppear {
            animateSteps()
        }
    }

    private func animateSteps() {
        for i in 0...steps.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.25) {
                withAnimation(.spring()) { visibleStep = i }
            }
        }
    }

    private func cleanText(_ raw: String) -> String {
        raw.replacingOccurrences(of: "**", with: "")
           .replacingOccurrences(of: "`", with: "")
    }
}

struct BulletListCard: View {
    let items: [String]
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                HStack(alignment: .top, spacing: 10) {
                    Circle()
                        .fill(accentColor)
                        .frame(width: 6, height: 6)
                        .padding(.top, 6)
                    Text(cleanText(item))
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.85))
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.05))
        )
    }

    private func cleanText(_ raw: String) -> String {
        raw.replacingOccurrences(of: "**", with: "")
           .replacingOccurrences(of: "`", with: "")
    }
}

struct TermGlossaryCard: View {
    let terms: [(term: String, definition: String)]
    let accentColor: Color
    @State private var expandedTerm: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "text.book.closed.fill")
                    .font(.system(size: 12))
                    .foregroundColor(accentColor)
                Text("Key Terms")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(accentColor)
                    .tracking(1)
                Spacer()
                Text("Tap to expand")
                    .font(.system(size: 10))
                    .foregroundColor(.white.opacity(0.3))
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 10)

            Divider().background(accentColor.opacity(0.2))

            ForEach(Array(terms.enumerated()), id: \.offset) { idx, pair in
                let isExpanded = expandedTerm == pair.term
                VStack(alignment: .leading, spacing: 0) {
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            expandedTerm = isExpanded ? nil : pair.term
                        }
                    } label: {
                        HStack {
                            Text(pair.term)
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundColor(isExpanded ? accentColor : .white)
                            Spacer()
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .font(.system(size: 11))
                                .foregroundColor(accentColor.opacity(0.7))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .contentShape(Rectangle())
                    }

                    if isExpanded {
                        Text(pair.definition)
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.75))
                            .lineSpacing(4)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(accentColor.opacity(0.08))
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    if idx < terms.count - 1 {
                        Divider().background(Color.white.opacity(0.06)).padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.05))
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(accentColor.opacity(0.25), lineWidth: 1))
        )
    }
}

struct CalloutCard: View {
    let emoji: String
    let title: String
    let message: String
    let accentColor: Color

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(emoji)
                .font(.system(size: 22))
            VStack(alignment: .leading, spacing: 4) {
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(accentColor)
                }
                Text(message.replacingOccurrences(of: "**", with: "").replacingOccurrences(of: "`", with: ""))
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.8))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(accentColor.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(accentColor.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct InlineCodeCard: View {
    let code: String
    let accentColor: Color
    @State private var copied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack(spacing: 5) {
                    ForEach([Color(hex: "FF5F57"), Color(hex: "FEBC2E"), Color(hex: "28C840")], id: \.self) { c in
                        Circle().fill(c).frame(width: 8, height: 8)
                    }
                }
                Spacer()
                Button {
                    UIPasteboard.general.string = code
                    withAnimation { copied = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation { copied = false }
                    }
                } label: {
                    Label(copied ? "Copied!" : "Copy", systemImage: copied ? "checkmark" : "doc.on.doc")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(copied ? .green : accentColor.opacity(0.8))
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(Color(hex: "E2E8F0"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "0D1117"))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(accentColor.opacity(0.2), lineWidth: 1))
        )
    }
}

struct SectionDividerView: View {
    let emoji: String
    let title: String
    let accentColor: Color

    var body: some View {
        HStack(spacing: 10) {
            Text(emoji)
                .font(.system(size: 18))
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Rectangle()
                .fill(accentColor.opacity(0.3))
                .frame(height: 1)
                .frame(maxWidth: 60)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Supporting

struct TagExplanation: Identifiable {
    let id = UUID()
    let tag: String
    let description: String
    let example: String?
}

// Simple flow layout for tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += lineHeight + spacing
                    lineHeight = 0
                }
                frames.append(CGRect(x: x, y: y, width: size.width, height: size.height))
                lineHeight = max(lineHeight, size.height)
                x += size.width + spacing
            }
            self.size = CGSize(width: maxWidth, height: y + lineHeight)
        }
    }
}
