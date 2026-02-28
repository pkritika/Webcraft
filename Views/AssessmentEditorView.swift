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
                htmlContent: htmlCode,
                cssContent: cssCode.isEmpty ? nil : cssCode,
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

        htmlCode = storage.load(for: assessmentStorageId, language: .html) ?? assessment.starterHTML
        cssCode  = storage.load(for: assessmentStorageId, language: .css) ?? assessment.starterCSS
        jsCode   = storage.load(for: assessmentStorageId, language: .javascript) ?? assessment.starterJS ?? ""
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
        let marker = assessment.htmlMarker
        let markedHTML = htmlCode.isEmpty ? "" : "\n\(marker)\n\(htmlCode)"
        let markedCSS  = "\n/* Assessment: \(assessment.title) */\n\(cssCode)"
        let markedJS   = jsCode.isEmpty ? "" : "\n// Assessment: \(assessment.title)\n\(jsCode)"

        // helper function to find the first index of any marker that structurally comes AFTER this assessment
        func findInsertionIndex(in code: String, isCSS: Bool = false, isJS: Bool = false) -> String.Index? {
            let sortedAssessments = PortfolioAssessment.allAssessments.sorted { $0.id < $1.id }
            guard let currentIndex = sortedAssessments.firstIndex(where: { $0.id == assessment.id }) else {
                return nil
            }
            
            // Check all assessments that come AFTER this one
            for nextAssesment in sortedAssessments[(currentIndex + 1)...] {
                let marker: String
                if isCSS {
                    marker = "/* Assessment: \(nextAssesment.title) */"
                } else if isJS {
                    marker = "// Assessment: \(nextAssesment.title)"
                } else {
                    marker = nextAssesment.htmlMarker
                }
                
                if !marker.isEmpty, let range = code.range(of: marker) {
                    return range.lowerBound
                }
            }
            return nil
        }

        // HTML: remove existing section, insert new
        if !marker.isEmpty {
            if portfolioService.portfolio.htmlCode.contains(marker) {
                if let markerRange = portfolioService.portfolio.htmlCode.range(of: marker) {
                    let sectionStart = markerRange.lowerBound
                    var sectionEnd   = portfolioService.portfolio.htmlCode.endIndex
                    let searchStart  = markerRange.upperBound
                    let allMarkers   = PortfolioAssessment.allAssessments.map { $0.htmlMarker }
                    for nextMarker in allMarkers {
                        if nextMarker != marker,
                           let nextRange = portfolioService.portfolio.htmlCode.range(of: nextMarker, range: searchStart..<portfolioService.portfolio.htmlCode.endIndex) {
                            sectionEnd = nextRange.lowerBound
                            break
                        }
                    }
                    if sectionEnd > sectionStart {
                        portfolioService.portfolio.htmlCode.removeSubrange(sectionStart..<sectionEnd)
                    }
                }
            }
            if !htmlCode.isEmpty {
                if let insertionIndex = findInsertionIndex(in: portfolioService.portfolio.htmlCode, isCSS: false, isJS: false) {
                    portfolioService.portfolio.htmlCode.insert(contentsOf: markedHTML + "\n", at: insertionIndex)
                } else if let scriptRange = portfolioService.portfolio.htmlCode.range(of: "<script") {
                    portfolioService.portfolio.htmlCode.insert(contentsOf: "\n" + markedHTML + "\n", at: scriptRange.lowerBound)
                } else {
                    portfolioService.portfolio.htmlCode += "\n" + markedHTML
                }
            }
        }

        // CSS: remove existing, insert new
        let cssMarker = "/* Assessment: \(assessment.title) */"
        if portfolioService.portfolio.cssCode.contains(cssMarker) {
            if let range = portfolioService.portfolio.cssCode.range(of: cssMarker) {
                let startIndex = range.lowerBound
                var endIndex   = portfolioService.portfolio.cssCode.endIndex
                let searchStart = range.upperBound
                for other in PortfolioAssessment.allAssessments where other.id != assessment.id {
                    let nextMarker = "/* Assessment: \(other.title) */"
                    if let nextRange = portfolioService.portfolio.cssCode.range(of: nextMarker, range: searchStart..<portfolioService.portfolio.cssCode.endIndex) {
                        endIndex = nextRange.lowerBound
                        break
                    }
                }
                if startIndex <= endIndex {
                    portfolioService.portfolio.cssCode.removeSubrange(startIndex..<endIndex)
                }
            }
        }
        if let cssInsertionIndex = findInsertionIndex(in: portfolioService.portfolio.cssCode, isCSS: true, isJS: false) {
            portfolioService.portfolio.cssCode.insert(contentsOf: markedCSS + "\n", at: cssInsertionIndex)
        } else {
            portfolioService.portfolio.cssCode += markedCSS
        }

        // JS: remove existing, insert new
        if !jsCode.isEmpty {
            let jsMarker = "// Assessment: \(assessment.title)"
            if portfolioService.portfolio.jsCode.contains(jsMarker) {
                if let range = portfolioService.portfolio.jsCode.range(of: jsMarker) {
                    let startIndex  = range.lowerBound
                    var endIndex    = portfolioService.portfolio.jsCode.endIndex
                    for other in PortfolioAssessment.allAssessments where other.id != assessment.id {
                        let nextMarker = "// Assessment: \(other.title)"
                        if let nextRange = portfolioService.portfolio.jsCode.range(of: nextMarker, range: range.upperBound..<portfolioService.portfolio.jsCode.endIndex) {
                            endIndex = nextRange.lowerBound
                            break
                        }
                    }
                    portfolioService.portfolio.jsCode.removeSubrange(startIndex..<endIndex)
                }
            }
            if let jsInsertionIndex = findInsertionIndex(in: portfolioService.portfolio.jsCode, isCSS: false, isJS: true) {
                portfolioService.portfolio.jsCode.insert(contentsOf: markedJS + "\n", at: jsInsertionIndex)
            } else {
                portfolioService.portfolio.jsCode += markedJS
            }
        }

        portfolioService.markSectionComplete(assessment.title)
        portfolioService.savePortfolio()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            saveStatus = .saved
        }
    }
}
