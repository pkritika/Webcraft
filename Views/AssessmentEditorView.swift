import SwiftUI

struct AssessmentEditorView: View {
    @EnvironmentObject var portfolioService: PortfolioService
    @Environment(\.dismiss) var dismiss

    let assessment: PortfolioAssessment

    // Code state
    @State private var htmlCode = ""
    @State private var cssCode = ""
    @State private var jsCode = ""
    @State private var selectedLanguage: CodeLanguage = .html

    // UI state
    @State private var saveStatus: SaveStatus = .saved
    @State private var showSaveSuccess = false
    @State private var saveWorkItem: DispatchWorkItem?
    @State private var showConfetti = false
    
    // Expandable box state
    @State private var isStepsExpanded = true
    @State private var isResultExpanded = true
    @State private var isBonusExpanded = true
    
    // Sidebar state for iPad
    @State private var isSidebarVisible = true
    
    // Reset alert state
    @State private var showResetAlert = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        ZStack {
            PremiumBackground()
            
            if horizontalSizeClass == .regular {
                // iPad / Mac layout
                HStack(spacing: 0) {
                    if isSidebarVisible {
                        ScrollView {
                            instructionSection
                        }
                        .frame(width: 380) // Fixed width sidebar for instructions
                        .transition(.move(edge: .leading))
                        
                        Divider()
                            .background(Color.appBorder)
                    }
                    
                    VStack(spacing: 0) {
                        editorSection
                        Divider()
                            .background(Color.appBorder)
                        previewSection
                        Divider()
                            .background(Color.appBorder)
                        saveButtonSection
                    }
                    .frame(maxWidth: .infinity)
                }
            } else {
                // iPhone / Compact layout
                ScrollView {
                    VStack(spacing: 0) {
                        instructionSection
                        Divider()
                            .background(Color.appBorder)
                        editorSection
                        Divider()
                            .background(Color.appBorder)
                        previewSection
                        Divider()
                            .background(Color.appBorder)
                        saveButtonSection
                    }
                }
            }
        }
        .navigationTitle(assessment.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if horizontalSizeClass == .regular {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isSidebarVisible.toggle()
                        }
                    }) {
                        Image(systemName: "sidebar.left")
                            .foregroundColor(.appPrimary)
                    }
                }
            }
        }
        .onAppear { loadCode() }
        .onChange(of: htmlCode) { _ in scheduleAutoSave() }
        .onChange(of: cssCode)  { _ in scheduleAutoSave() }
        .onChange(of: jsCode)   { _ in scheduleAutoSave() }
        .overlay {
            if showSaveSuccess {
                saveSuccessOverlay
            }
        }
        .overlay {
            if showConfetti {
                ConfettiView()
            }
        }
    }

    // MARK: - Sections

    private var editorSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Code Editor")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                Spacer()
                SaveIndicator(status: saveStatus)
            }
            .padding()
            .background(Color.cardBackground)

            EnhancedCodeEditor(
                htmlCode: $htmlCode,
                cssCode: $cssCode,
                jsCode: $jsCode,
                selectedLanguage: $selectedLanguage
            )
            .frame(minHeight: 250, maxHeight: horizontalSizeClass == .regular ? .infinity : 320)
        }
    }

    /// Merges `cssCode` into `htmlCode` for preview.
    /// If `htmlCode` is already a full document (has a `<head>` tag) we inject
    /// the CSS there; otherwise we leave them separate and let HTMLPreview combine them.
    private var previewHTML: String {
        guard !cssCode.isEmpty else { return htmlCode }

        // Detect a full HTML document by looking for a <head> tag (case-insensitive)
        let lower = htmlCode.lowercased()
        if let headCloseRange = lower.range(of: "</head>") {
            // Inject user CSS just before </head>
            let injected = "\n<style>\n\(cssCode)\n</style>\n"
            var merged = htmlCode
            merged.insert(contentsOf: injected, at: headCloseRange.lowerBound)
            return merged
        }

        // Not a full document — HTMLPreview will handle combining them normally.
        return htmlCode
    }

    private var previewSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Preview")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                Spacer()
            }
            .padding()
            .background(Color.cardBackground)

            HTMLPreview(
                // Pass the pre-merged HTML so HTMLPreview doesn't double-wrap
                htmlContent: previewHTML,
                // When the document is already full, CSS is already injected; pass nil
                cssContent: htmlCode.lowercased().contains("</head>") ? nil : (cssCode.isEmpty ? nil : cssCode),
                jsContent: nil // Explicitly pass nil to disable JS preview
            )
            .frame(minHeight: 300, maxHeight: horizontalSizeClass == .regular ? .infinity : 420)
            .background(Color.white)
        }
    }

    private var saveButtonSection: some View {
        VStack(spacing: 12) {
            Button {
                showConfetti = true
                HapticManager.shared.triggerCelebration()
                saveToPortfolio()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showSaveSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "tray.and.arrow.down.fill")
                        .font(.system(size: 16, weight: .semibold))
                    Text(portfolioService.portfolio.completedSections.contains(assessment.title) ? "Update Portfolio" : "Save to Portfolio")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(portfolioService.portfolio.completedSections.contains(assessment.title) ? Color(hex: assessment.color) : .black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(portfolioService.portfolio.completedSections.contains(assessment.title) ? Color.clear : Color(hex: assessment.color))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: assessment.color), lineWidth: portfolioService.portfolio.completedSections.contains(assessment.title) ? 2 : 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Button {
                showResetAlert = true
            } label: {
                Text("Reset to Starter Code")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.cardBackground)
        .alert("Reset Code?", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                resetToStarterCode()
            }
        } message: {
            Text("This will delete your current code for this assessment and bring back the original starter code.")
        }
    }

    private func resetToStarterCode() {
        // Overwrite standard variables
        htmlCode = assessment.starterHTML
        cssCode = assessment.starterCSS
        jsCode = assessment.starterJS ?? ""
        // Force save to local storage immediately
        let storage = CodeStorageService.shared
        storage.save(code: htmlCode, for: assessmentStorageId, language: .html)
        storage.save(code: cssCode,  for: assessmentStorageId, language: .css)
        storage.save(code: jsCode,   for: assessmentStorageId, language: .javascript)
        
        // Save the new hash so we know we're up to date
        storage.saveStarterHash(hash: currentStarterHash, for: assessmentStorageId)
        
        // Clear the edited flag since this is fresh starter code
        storage.clearEditedFlag(for: assessmentStorageId)
    }

    private var saveSuccessOverlay: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.green)
            Text("Saved to Portfolio!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.85))
        .transition(.opacity)
    }

    // MARK: - Instructions section

    private var instructionSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Icon + title
            HStack(spacing: 16) {
                Image(systemName: assessment.icon)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(Color(hex: assessment.color))
                VStack(alignment: .leading, spacing: 4) {
                    Text(assessment.title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.textPrimary)
                    Text(assessment.description)
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                }
            }

            // 1. What you're building
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Text("📌")
                    Text("What you're building")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(hex: "#60A5FA"))
                        .textCase(.uppercase)
                }
                Text(assessment.whatYoureBuilding)
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "#CBD5E1"))
                    .lineSpacing(4)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "#0F172A"))
            .overlay(
                Rectangle()
                    .fill(Color(hex: "#60A5FA"))
                    .frame(width: 4),
                alignment: .leading
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // 2. Steps
            DisclosureGroup(isExpanded: $isStepsExpanded) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(assessment.steps.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(hex: "#94A3B8"))
                                .frame(width: 24, height: 24)
                                .background(Color(hex: "#2D3748"))
                                .clipShape(Circle())
                            
                            Text(LocalizedStringKey(step))
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: "#CBD5E1"))
                                .lineSpacing(4)
                                .padding(.top, 2)
                        }
                    }
                }
                .padding(.top, 12)
            } label: {
                Text("STEPS")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(hex: "#64748B"))
                    .textCase(.uppercase)
            }
            .accentColor(Color(hex: "#64748B"))

            // 3. Expected Result
            DisclosureGroup(isExpanded: $isResultExpanded) {
                Text(assessment.expectedResult)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#86EFAC"))
                    .lineSpacing(4)
                    .padding(.top, 8)
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(hex: "#34D399"))
                    Text("Expected Result")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(hex: "#86EFAC"))
                }
            }
            .accentColor(Color(hex: "#86EFAC"))
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "#0D1F0D"))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#1A4D1A"), lineWidth: 1)
            )

            // 4. Bonus Challenge
            DisclosureGroup(isExpanded: $isBonusExpanded) {
                Text(LocalizedStringKey("**Extra challenge:** \(assessment.bonusChallenge.replacingOccurrences(of: "Extra challenge: ", with: ""))"))
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#C4B5FD"))
                    .lineSpacing(4)
                    .padding(.top, 8)
            } label: {
                HStack(spacing: 8) {
                    Text("⭐")
                    Text("Bonus")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(hex: "#A78BFA"))
                }
            }
            .accentColor(Color(hex: "#A78BFA"))
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "#1C1433"))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#4C1D95"), lineWidth: 1)
            )

            // Info footer
            HStack(spacing: 6) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: assessment.color))
                Text("Your code automatically saves to your portfolio")
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary)
            }
            .padding(.top, 8)
        }
        .padding(24)
        .background(Color(hex: "#1E2433"))
    }

    // ── Use offset IDs to avoid collision with lesson IDs ──
    private var assessmentStorageId: Int { 1000 + assessment.id }

    private var currentStarterHash: Int {
        var hasher = Hasher()
        hasher.combine(assessment.starterHTML)
        hasher.combine(assessment.starterCSS)
        hasher.combine(assessment.starterJS ?? "")
        return hasher.finalize()
    }

    private func loadCode() {
        let storage = CodeStorageService.shared

        let savedHash = storage.loadStarterHash(for: assessmentStorageId)
        let isCodeEdited = storage.hasBeenEdited(for: assessmentStorageId)
        let currentHash = currentStarterHash

        // If the starter code was updated by the developer AND the user hasn't edited their code,
        // OR if there is no code saved at all, we load the fresh starter code.
        if !storage.hasCode(for: assessmentStorageId) || (savedHash != currentHash && !isCodeEdited) {
            resetToStarterCode() // This will save the new hash and reset the code
            return
        }

        // Load saved code with fallback to starter code
        let loadedHTML = storage.load(for: assessmentStorageId, language: .html) ?? ""
        let loadedCSS  = storage.load(for: assessmentStorageId, language: .css) ?? ""
        let loadedJS   = storage.load(for: assessmentStorageId, language: .javascript) ?? ""

        // If HTML is empty but we have CSS, something went wrong - reset to starter
        if loadedHTML.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !assessment.starterHTML.isEmpty {
            print("⚠️ HTML is empty but should have content - resetting to starter code")
            resetToStarterCode()
            return
        }

        htmlCode = loadedHTML.isEmpty ? assessment.starterHTML : loadedHTML
        cssCode  = loadedCSS.isEmpty ? assessment.starterCSS : loadedCSS
        jsCode   = loadedJS.isEmpty ? (assessment.starterJS ?? "") : loadedJS
        saveStatus = .saved
    }

    private func scheduleAutoSave() {
        saveStatus = .modified
        saveWorkItem?.cancel()
        
        let storage = CodeStorageService.shared
        
        // If they start typing, mark it as edited so we don't overwrite it later
        if !storage.hasBeenEdited(for: assessmentStorageId) {
            storage.markAsEdited(for: assessmentStorageId)
        }
        
        storage.save(code: htmlCode, for: assessmentStorageId, language: .html)
        storage.save(code: cssCode,  for: assessmentStorageId, language: .css)
        storage.save(code: jsCode,   for: assessmentStorageId, language: .javascript)
        
        let workItem = DispatchWorkItem { saveToPortfolio() }
        saveWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: workItem)
    }

    private func saveToPortfolio() {
        saveStatus = .saving

        let navMarker    = "<!-- LAYOUT-NAV -->"
        let footerMarker = "<!-- LAYOUT-FOOTER -->"

        // Canonical display order (sorted by id); LAYOUT-NAV / LAYOUT-FOOTER handled separately
        let orderedAssessments = PortfolioAssessment.allAssessments.sorted { $0.id < $1.id }

        // All markers that can appear in the body, in order
        let allBodyMarkers: [String] = [navMarker]
            + orderedAssessments.map { $0.htmlMarker }
            + [footerMarker]

        // ── Helper: extract the raw content that lives between two markers ──
        func extractContent(after startMarker: String, from html: String) -> String {
            guard html.contains(startMarker),
                  let markerRange = html.range(of: startMarker) else { return "" }
            let contentStart = markerRange.upperBound
            var contentEnd   = html.endIndex

            // Stop at the next known marker or </body>
            let startIdx = allBodyMarkers.firstIndex(of: startMarker) ?? 0
            for marker in allBodyMarkers.dropFirst(startIdx + 1) {
                if let r = html.range(of: marker, range: contentStart..<html.endIndex) {
                    contentEnd = min(contentEnd, r.lowerBound)
                }
            }
            if let bodyClose = html.range(of: "</body>", range: contentStart..<html.endIndex) {
                contentEnd = min(contentEnd, bodyClose.lowerBound)
            }
            return String(html[contentStart..<contentEnd]).trimmingCharacters(in: .whitespacesAndNewlines)
        }

        // ── Step 1: Snapshot all existing section contents ──
        var htmlSections: [String: String] = [:]   // marker → content
        let existingHTML = portfolioService.portfolio.htmlCode
        for marker in allBodyMarkers {
            let content = extractContent(after: marker, from: existingHTML)
            if !content.isEmpty { htmlSections[marker] = content }
        }

        // ── Step 2: Update the current assessment's content ──
        if assessment.htmlMarker == navMarker {
            // Split at <footer so nav goes to the top and footer to the bottom
            let lowerHTML = htmlCode.lowercased()
            if let footerIdx = lowerHTML.range(of: "<footer") {
                let offset   = lowerHTML.distance(from: lowerHTML.startIndex, to: footerIdx.lowerBound)
                let splitIdx = htmlCode.index(htmlCode.startIndex, offsetBy: offset)
                let nav    = String(htmlCode[..<splitIdx]).trimmingCharacters(in: .whitespacesAndNewlines)
                let footer = String(htmlCode[splitIdx...]).trimmingCharacters(in: .whitespacesAndNewlines)
                if !nav.isEmpty    { htmlSections[navMarker]    = nav }
                if !footer.isEmpty { htmlSections[footerMarker] = footer }
            } else {
                let nav = htmlCode.trimmingCharacters(in: .whitespacesAndNewlines)
                if !nav.isEmpty { htmlSections[navMarker] = nav }
            }
        } else {
            let content = htmlCode.trimmingCharacters(in: .whitespacesAndNewlines)
            if !content.isEmpty {
                htmlSections[assessment.htmlMarker] = content
            } else {
                htmlSections.removeValue(forKey: assessment.htmlMarker)
            }
        }

        // ── Step 3: Rebuild the full HTML in canonical order ──
        // Preserve everything up to and including <body>
        var head = ""
        if let bodyRange = existingHTML.range(of: "<body>") {
            head = String(existingHTML[existingHTML.startIndex...bodyRange.upperBound])
        } else {
            head = """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Portfolio</title>
                <link rel="stylesheet" href="styles.css">
            </head>
            <body>
            """
        }

        var newBody = ""

        // Nav first
        if let navContent = htmlSections[navMarker] {
            newBody += "\n\(navMarker)\n\(navContent)\n"
        }

        // Content sections in canonical order
        for a in orderedAssessments where a.htmlMarker != navMarker {
            if let content = htmlSections[a.htmlMarker] {
                newBody += "\n\(a.htmlMarker)\n\(content)\n"
            }
        }

        // Footer last
        if let footerContent = htmlSections[footerMarker] {
            newBody += "\n\(footerMarker)\n\(footerContent)\n"
        }

        newBody += "\n    <script src=\"script.js\"></script>\n</body>\n</html>"
        portfolioService.portfolio.htmlCode = head + newBody

        // ── CSS: parse existing sections, update current, rebuild in order ──
        let cssTitle   = "/* Assessment: \(assessment.title) */"
        let allCSSTitles = orderedAssessments.map { "/* Assessment: \($0.title) */" }

        func extractCSS(after title: String, from css: String) -> String {
            guard css.contains(title), let r = css.range(of: title) else { return "" }
            let start = r.lowerBound      // keep the marker line itself
            var end   = css.endIndex
            let rest  = r.upperBound
            for other in allCSSTitles where other != title {
                if let nr = css.range(of: other, range: rest..<css.endIndex) {
                    end = min(end, nr.lowerBound)
                }
            }
            return String(css[start..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
        }

        var cssSections: [String: String] = [:]
        let existingCSS = portfolioService.portfolio.cssCode
        // Preserve the preamble (everything before the first assessment marker)
        var cssPreamble = existingCSS
        for title in allCSSTitles {
            if let r = existingCSS.range(of: title) {
                let candidate = String(existingCSS[existingCSS.startIndex..<r.lowerBound])
                if candidate.count < cssPreamble.count { cssPreamble = candidate }
            }
        }
        // Extract each section
        for a in orderedAssessments {
            let title   = "/* Assessment: \(a.title) */"
            let content = extractCSS(after: title, from: existingCSS)
            if !content.isEmpty { cssSections[title] = content }
        }
        // Update current assessment's CSS
        let newCSSBlock = "/* Assessment: \(assessment.title) */\n\(cssCode)"
        cssSections[cssTitle] = newCSSBlock

        // Rebuild CSS in canonical order
        var newCSS = cssPreamble.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? "/* Your CSS styles will be added here */\n* { box-sizing: border-box; }\nbody { font-family: -apple-system, sans-serif; line-height: 1.6; color: #333; }"
            : cssPreamble.trimmingCharacters(in: .whitespacesAndNewlines)
        for a in orderedAssessments {
            let title = "/* Assessment: \(a.title) */"
            if let block = cssSections[title] {
                newCSS += "\n\n\(block)"
            }
        }
        portfolioService.portfolio.cssCode = newCSS

        // ── JS: update in-place (order matters less for JS) ──
        if !jsCode.isEmpty {
            let jsMarker = "// Assessment: \(assessment.title)"
            if portfolioService.portfolio.jsCode.contains(jsMarker),
               let range = portfolioService.portfolio.jsCode.range(of: jsMarker) {
                var endIndex = portfolioService.portfolio.jsCode.endIndex
                for other in orderedAssessments where other.id != assessment.id {
                    let otherMarker = "// Assessment: \(other.title)"
                    if let nr = portfolioService.portfolio.jsCode.range(of: otherMarker, range: range.upperBound..<portfolioService.portfolio.jsCode.endIndex) {
                        endIndex = min(endIndex, nr.lowerBound)
                    }
                }
                portfolioService.portfolio.jsCode.removeSubrange(range.lowerBound..<endIndex)
            }
            portfolioService.portfolio.jsCode += "\n// Assessment: \(assessment.title)\n\(jsCode)"
        }

        portfolioService.markSectionComplete(assessment.title)
        portfolioService.savePortfolio()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            saveStatus = .saved
        }
    }
}
