//
//  LessonView.swift
//  WebCraft
//
//  Redesigned with split-screen code editor and live preview
//

import SwiftUI
import Combine

struct LessonView: View {
    @EnvironmentObject var progressService: ProgressService
    @EnvironmentObject var portfolioService: PortfolioService
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let lesson: Lesson
    @State var currentSection = 0
    
    // Multi-language code state (from portfolio)
    @State var htmlCode = ""
    @State var cssCode = ""
    @State var jsCode = ""
    @State var selectedLanguage: CodeLanguage = .html
    
    // UI state
    @State var saveStatus: SaveStatus = .saved
    @State var validationResult: ValidationResult?
    @State var showSaveConfirmation = false
    @State private var showConfetti = false
    
    // Save & Complete feedback
    @State private var showSaveSuccess = false
    @State var saveWorkItem: DispatchWorkItem?
    
    var currentLessonSection: LessonSection? {
        guard currentSection >= 0 && currentSection < lesson.sections.count else {
            return nil
        }
        return lesson.sections[currentSection]
    }
    
    var isLandscape: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        VStack(spacing: 0) {
                // Dot progress indicators
                HStack(spacing: 8) {
                    ForEach(0..<lesson.sections.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentSection ? Color.appPrimary : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .accessibilityHidden(true)
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Section \(currentSection + 1) of \(lesson.sections.count)")
                .accessibilityHint("Progress through lesson sections")
                
                if let section = currentLessonSection {
                    if section.type == .practice {
                        // Practice mode: ALWAYS show paged practice view (NOT dark slides)
                        pagedPracticeView
                    } else {
                        // Theory/Example mode: Single scrollable page with buttons
                        VStack(spacing: 0) {
                            // Scrollable content page
                            AnimatedSectionView(section: section)
                            
                            // Section navigation buttons (move between sections)
                            HStack(spacing: 12) {
                                if currentSection > 0 {
                                    Button {
                                        currentSection -= 1
                                    } label: {
                                        HStack(spacing: 6) {
                                            Image(systemName: "chevron.left")
                                                .font(.system(size: 14, weight: .semibold))
                                            Text("Previous")
                                                .font(.system(size: 15, weight: .medium))
                                        }
                                        .foregroundColor(.white.opacity(0.8))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                        .background(Color.white.opacity(0.15))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .accessibilityLabel("Previous section")
                                    .accessibilityHint("Go back to the previous lesson section")
                                }

                                Spacer()

                                if currentSection < lesson.sections.count - 1 {
                                    Button {
                                        currentSection += 1
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text("Next Section")
                                                .font(.system(size: 15, weight: .semibold))
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14, weight: .semibold))
                                        }
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 12)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .accessibilityLabel("Next section")
                                    .accessibilityHint("Continue to the next lesson section")
                                } else {
                                    Button {
                                        progressService.completeLesson(lesson)
                                        dismiss()
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text("Complete")
                                                .font(.system(size: 15, weight: .semibold))
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 14, weight: .semibold))
                                        }
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 12)
                                        .background(Color.green)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .accessibilityLabel("Complete lesson")
                                    .accessibilityHint("Mark this lesson as complete and return to dashboard")
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.clear)
                        }
                    }
                } else {
                    Spacer()
                }
            }
            .overlay {
                if showConfetti {
                    ConfettiView()
                }
            }
        .background(PremiumBackground())
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Remove navigation bar separator line
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.shadowColor = .clear // Remove separator line
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            loadSavedOrStarterCode()
        }
        .onChange(of: htmlCode) { _ in scheduleAutoSave() }
        .onChange(of: cssCode) { _ in scheduleAutoSave() }
        .onChange(of: jsCode) { _ in scheduleAutoSave() }
        .onChange(of: currentSection) { _ in
            loadCodeForCurrentSection()
            validationResult = nil
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        HStack {
            if let section = currentLessonSection, section.type == .practice {
                SaveIndicator(status: saveStatus)
            }
            
            Spacer()
            
            if let section = currentLessonSection, section.type == .practice {
                Button(action: resetCode) {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.orange.opacity(0.1))
                        .foregroundColor(.orange)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.05))
    }
    
    // MARK: - Split Screen View
    
    private var splitScreenView: some View {
        GeometryReader { geometry in
            if isLandscape {
                // Horizontal split for landscape
                HStack(spacing: 0) {
                    editorPanel
                        .frame(width: geometry.size.width * 0.5)
                    
                    Divider()
                    
                    previewPanel
                        .frame(width: geometry.size.width * 0.5)
                }
            } else {
                // Vertical split for portrait
                VStack(spacing: 0) {
                    editorPanel
                        .frame(height: geometry.size.height * 0.55)
                    
                    Divider()
                    
                    previewPanel
                        .frame(height: geometry.size.height * 0.45)
                }
            }
        }
    }
    
    private var editorPanel: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let section = currentLessonSection {
                // Instructions
                VStack(alignment: .leading, spacing: 6) {
                    Text(section.title)
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                    
                    Text(section.content)
                        .font(.subheadline)
                        .foregroundColor(.textSecondary)
                    
                    if let challenge = section.challenge {
                        Text(challenge.instruction)
                            .font(.subheadline)
                            .foregroundColor(.appPrimary)
                    }
                }
                .padding(12)
                .background(Color.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            
            // Code editor
            EnhancedCodeEditor(
                htmlCode: $htmlCode,
                cssCode: $cssCode,
                jsCode: $jsCode,
                selectedLanguage: $selectedLanguage
            )
        }
    }
    
    private var previewPanel: some View {
        VStack(spacing: 0) {
            // Preview header
            HStack {
                Text("Preview")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                Spacer()
                Button(action: refreshPreview) {
                    Image(systemName: "arrow.clockwise")
                        .font(.caption)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.black)
            
            // Live preview
            HTMLPreview(
                htmlContent: htmlCode,
                cssContent: cssCode.isEmpty ? nil : cssCode,
                jsContent: jsCode.isEmpty ? nil : jsCode
            )
            .id("\(htmlCode.hashValue)-\(cssCode.hashValue)-\(jsCode.hashValue)")
            .background(Color.cardBackground)
            .border(Color.gray.opacity(0.3))
        }
    }
    
    // MARK: - Theory Content View
    
    private func theoryContentView(section: LessonSection) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(section.title)
                .font(.title2)
                .bold()
                .foregroundColor(.textPrimary)
            
            Text(section.content)
                .foregroundColor(.textSecondary)
            
            if let code = section.codeExample {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Example:")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Text(code)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.green)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    // MARK: - Controls View
    
    private var controlsView: some View {
        HStack {
            if currentSection > 0 {
                Button("Previous") {
                    currentSection -= 1
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            
            Spacer()
            
            if let section = currentLessonSection, section.type == .practice, let challenge = section.challenge {
                Button("Check Code") {
                    validationResult = HTMLValidator.validate(html: htmlCode, against: challenge.validationRules)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if let result = validationResult {
                    Text(result.isValid ? "✓ Correct!" : "Try again")
                        .foregroundColor(result.isValid ? .green : .red)
                        .font(.caption)
                }
            }
            
            Spacer()
            
            if currentSection < lesson.sections.count - 1 {
                Button("Next") {
                    currentSection += 1
                }
                .padding()
                .background(Color.appPrimary)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Complete") {
                    showConfetti = true
                    HapticManager.shared.triggerCelebration()
                    saveCurrentCode() // Save before completing
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        progressService.completeLesson(lesson)
                        dismiss()
                    }
                }
                .padding()
                .background(Color.appPrimary)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
    
    // MARK: - Code Management
    
    private func loadSavedOrStarterCode() {
        loadCodeForCurrentSection()
    }
    
    private func loadCodeForCurrentSection() {
        guard let section = currentLessonSection else {
            return
        }
        
        // Only load code for practice sections
        guard section.type == .practice, let challenge = section.challenge else {
            return
        }
        
        // IMPORTANT: Each lesson should show its UNIQUE starter code
        // This is what the user will ADD to their portfolio
        
        // SMART LOADING: Only overwrite editor if starter code is provided
        // This allows code to persist between sections (e.g. HTML -> CSS)
        
        if !challenge.starterCode.isEmpty {
            htmlCode = challenge.starterCode
        }
        
        // Always load CSS/JS if provided, or clear if we need to ensure a clean state?
        // Actually, for CSS steps, we usually want to overwrite or add.
        // If starterCSS is nil/empty, we might want to keep existing CSS (if any) or clear it.
        // For now, let's treat CSS/JS similarly: if provided, use it.
        
        if let css = challenge.starterCSS, !css.isEmpty {
            cssCode = css
        }
        
        if let js = challenge.starterJS, !js.isEmpty {
            jsCode = js
        }
        
        saveStatus = .saved
    }
    
    private func scheduleAutoSave() {
        saveStatus = .modified
        
        // Cancel previous save
        saveWorkItem?.cancel()
        
        // Schedule new save
        let workItem = DispatchWorkItem { [self] in
            saveCurrentCode()
        }
        saveWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: workItem)
    }
    
    func saveCurrentCode() {
        saveStatus = .saving
        
        // SMART INSERTION: Insert code in correct position based on lesson order
        // Maintains logical structure: Header → Nav → About → Skills → Projects → Contact → Footer
        
        // Define section markers for each lesson type
        // UPDATED: Matches new 21-lesson curriculum
        let sectionMarkers = [
            1: "<!-- HEADER -->",
            2: "<!-- ABOUT -->",
            3: "<!-- SKILLS -->",
            4: "<!-- LINKS -->",
            5: "<!-- GALLERY -->",
            9: "<!-- PROJECTS -->",
            10: "<!-- NAVIGATION -->",
            // Phase 3: Responsive Updates
            11: "<!-- HEADER -->",     // Responsive Header
            12: "<!-- SKILLS -->",     // Responsive Skills
            13: "<!-- PROJECTS -->",   // Responsive Projects
            14: "<!-- NAVIGATION -->", // Responsive Nav
            // Phase 4: JavaScript Updates
            15: "<!-- HEADER -->",     // Interactive Header
            16: "<!-- SKILLS -->",     // Interactive Skills
            17: "<!-- CONTACT -->",    // Validated Contact Form
            18: "<!-- NAVIGATION -->"  // Dark Mode Nav
        ]
        
        // Get current lesson ID
        let lessonId = lesson.id
        
        // Check if this lesson's code is already in the portfolio
        let marker = sectionMarkers[lessonId] ?? ""
        
        // Only wrap in marker if we have one defined (skip theory/CSS-only lessons for HTML)
        let markedHTML = marker.isEmpty || htmlCode.isEmpty ? "" : "\n\(marker)\n\(htmlCode)"
        
        let markedCSS = "\n/* Lesson \(lessonId) */\n\(cssCode)"
        let markedJS = jsCode.isEmpty ? "" : "\n// Lesson \(lessonId)\n\(jsCode)"
        
        // For HTML: Remove existing section if present, then insert updated version
        // Only if we have HTML to save or a marker to look for
        if !marker.isEmpty {
            if portfolioService.portfolio.htmlCode.contains(marker) {
                portfolioService.portfolio.htmlCode = removeSection(
                    from: portfolioService.portfolio.htmlCode,
                    lessonId: lessonId,
                    markers: sectionMarkers
                )
            }
            
            // Always insert the new/updated section if we have content
            if !htmlCode.isEmpty {
                portfolioService.portfolio.htmlCode = insertInCorrectPosition(
                    content: markedHTML,
                    into: portfolioService.portfolio.htmlCode,
                    lessonId: lessonId,
                    markers: sectionMarkers
                )
            }
        }
        
        // For CSS: Remove existing, then insert in order
        let cssMarker = "/* Lesson \(lessonId) */"
        if portfolioService.portfolio.cssCode.contains(cssMarker) {
            if let range = portfolioService.portfolio.cssCode.range(of: cssMarker) {
                let startIndex = range.lowerBound
                var endIndex = portfolioService.portfolio.cssCode.endIndex

                let searchStart = range.upperBound
                if lessonId < 21 {
                    for nextId in (lessonId + 1)...21 {
                        let nextMarker = "/* Lesson \(nextId) */"
                        if let nextRange = portfolioService.portfolio.cssCode.range(of: nextMarker, range: searchStart..<portfolioService.portfolio.cssCode.endIndex) {
                            endIndex = nextRange.lowerBound
                            break
                        }
                    }
                }

                if startIndex <= endIndex {
                    portfolioService.portfolio.cssCode.removeSubrange(startIndex..<endIndex)
                }
            }
        }
        
        var cssInserted = false
        if lessonId < 21 {
            for nextId in (lessonId + 1)...21 {
                let nextMarker = "/* Lesson \(nextId) */"
                if let nextRange = portfolioService.portfolio.cssCode.range(of: nextMarker) {
                    portfolioService.portfolio.cssCode.insert(contentsOf: markedCSS + "\n", at: nextRange.lowerBound)
                    cssInserted = true
                    break
                }
            }
        }
        if !cssInserted {
            portfolioService.portfolio.cssCode += markedCSS
        }
        
        // For JS: Remove existing, then insert in order
        if !jsCode.isEmpty {
            let jsMarker = "// Lesson \(lessonId)"
            if portfolioService.portfolio.jsCode.contains(jsMarker) {
                if let range = portfolioService.portfolio.jsCode.range(of: jsMarker) {
                    let startIndex = range.lowerBound
                    var endIndex = portfolioService.portfolio.jsCode.endIndex
                    for nextId in (lessonId + 1)...21 {
                        let nextMarker = "// Lesson \(nextId)"
                        if let nextRange = portfolioService.portfolio.jsCode.range(of: nextMarker, range: range.upperBound..<portfolioService.portfolio.jsCode.endIndex) {
                            endIndex = nextRange.lowerBound
                            break
                        }
                    }
                    if startIndex <= endIndex {
                        portfolioService.portfolio.jsCode.removeSubrange(startIndex..<endIndex)
                    }
                }
            }
            
            var jsInserted = false
            if lessonId < 21 {
                for nextId in (lessonId + 1)...21 {
                    let nextMarker = "// Lesson \(nextId)"
                    if let nextRange = portfolioService.portfolio.jsCode.range(of: nextMarker) {
                        portfolioService.portfolio.jsCode.insert(contentsOf: markedJS + "\n", at: nextRange.lowerBound)
                        jsInserted = true
                        break
                    }
                }
            }
            if !jsInserted {
                portfolioService.portfolio.jsCode += markedJS
            }
        }
        
        // Mark section as complete
        if let section = currentLessonSection {
            portfolioService.markSectionComplete(section.title)
        }
        
        // Trigger manual save for immediate feedback
        portfolioService.savePortfolio()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            saveStatus = .saved
            showSaveConfirmation = true
            
            // Hide confirmation after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showSaveConfirmation = false
            }
        }
    }
    
    // Helper to insert HTML in correct position
    private func insertInCorrectPosition(content: String, into existing: String, lessonId: Int, markers: [Int: String]) -> String {
        // If portfolio is empty, just add it
        if existing.isEmpty || existing.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return content
        }
        
        // Find where to insert based on lesson order
        var result = existing
        var inserted = false
        
        // Check lessons after this one to find insertion point
        // Only iterate if there are lessons after this one
        if lessonId < 21 {
            for nextLessonId in (lessonId + 1)...21 {
                if let nextMarker = markers[nextLessonId], result.contains(nextMarker) {
                    // Insert before the next lesson
                    result = result.replacingOccurrences(of: nextMarker, with: content + "\n" + nextMarker)
                    inserted = true
                    break
                }
            }
        }
        
        // If no later lessons found, append at end of body content (before any scripts if possible, or just end)
        // Simplification: Append to end (Layout usually depends on container order)
        if !inserted {
            // Try to insert before script tag if it exists at end of body
            if let scriptRange = result.range(of: "<script") {
                 result.insert(contentsOf: content + "\n", at: scriptRange.lowerBound)
            } else {
                 result += "\n" + content
            }
        }
        
        return result
    }
    
    // Helper to remove existing section before updating
    private func removeSection(from existing: String, lessonId: Int, markers: [Int: String]) -> String {
        guard let marker = markers[lessonId], existing.contains(marker) else {
            return existing
        }
        
        var result = existing
        
        // Find the start of this lesson's section
        if let markerRange = result.range(of: marker) {
            let sectionStart = markerRange.lowerBound
            
            // Find the end (next lesson's marker or end of string)
            var sectionEnd = result.endIndex
            
            // Search for next marker ONLY after the current marker
            // This prevents finding markers that might be out of order or earlier in the file
            let searchStart = markerRange.upperBound
            
            // Check for any later lesson markers
            if lessonId < 21 {
                for nextId in (lessonId + 1)...21 {
                    if let nextMarker = markers[nextId], 
                       let nextRange = result.range(of: nextMarker, range: searchStart..<result.endIndex) {
                        sectionEnd = nextRange.lowerBound
                        break
                    }
                }
            }
            
            // Safety check: Ensure end is after start
            if sectionEnd >= sectionStart {
                // Remove the section
                result.removeSubrange(sectionStart..<sectionEnd)
            }
        }
        
        return result
    }
    
    func resetCode() {
        guard let section = currentLessonSection, let challenge = section.challenge else {
            return
        }
        
        // Only overwrite if starter code is provided (allows chaining sections)
        if !challenge.starterCode.isEmpty {
            htmlCode = challenge.starterCode
        }
        
        if let css = challenge.starterCSS, !css.isEmpty {
            cssCode = css
        }
        
        if let js = challenge.starterJS, !js.isEmpty {
            jsCode = js
        }
        
        saveCurrentCode()
    }
    
    private func refreshPreview() {
        // Trigger a reload by toggling a state
        //showPreview = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            //showPreview = true
        }
    }
}

