//
//  LessonViewPaged.swift
//  WebCraft
//
//  Paged scroll: Page 1 = Instructions, Page 2 = Editor/Preview
//

import SwiftUI

extension LessonView {
    // MARK: - Paged Practice View
    
    var pagedPracticeView: some View {
        GeometryReader { geometry in
            let safeHeight = max(geometry.size.height, 100)
            let safeWidth  = max(geometry.size.width,  100)

            TabView {
                // PAGE 1: Instructions
                LessonInstructionPage(lesson: lesson)
                    .frame(width: safeWidth, height: safeHeight)

                // PAGE 2: Editor & Preview
                editorPreviewPage
                    .frame(width: safeWidth, height: safeHeight)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color.black)
            .ignoresSafeArea()
        }
    }
    
    // MARK: - Page 1: Instructions
    
    var instructionPage: some View {
        VStack(spacing: 0) {
            // Top buttons
            HStack(spacing: 12) {
                if currentSection > 0 {
                    Button {
                        currentSection -= 1
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.textPrimary)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                StyledActionButton(title: "Reset", style: .reset) {
                    resetCode()
                }
                
                if currentSection < lesson.sections.count - 1 {
                    Button {
                        currentSection += 1
                    } label: {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.textPrimary)
                            .padding()
                            .background(Color.appPrimary.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color.appBackground)
            
            // Instructions content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let section = currentLessonSection {
                        Text(section.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.textPrimary)
                        
                        Text(section.content)
                            .font(.body)
                            .foregroundColor(.textSecondary)
                        
                        if let challenge = section.challenge {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Your Task")
                                    .font(.title2)
                                    .foregroundColor(.appPrimary)
                                
                                Text(challenge.instruction)
                                    .font(.body)
                                    .foregroundColor(.textPrimary)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.cardBackground)
                                    .cornerRadius(12)
                            }
                        }
                        
                        
                        // Scroll hint
                        VStack(spacing: 8) {
                            Image(systemName: "arrow.down")
                                .font(.title2)
                                .foregroundColor(.textSecondary)
                            Text("Scroll down to code")
                                .font(.caption)
                                .foregroundColor(.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)
                    }
                }
                .padding()
            }
        }
        .background(Color.appBackground)
    }
    
    // MARK: - Page 2: Editor & Preview
    
    var editorPreviewPage: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Top bar
                    HStack {
                        Text("Code Editor")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.cardBackground)
                    
                    // Editor
                    EnhancedCodeEditor(
                        htmlCode: $htmlCode,
                        cssCode: $cssCode,
                        jsCode: $jsCode,
                        selectedLanguage: $selectedLanguage
                    )
                    .frame(height: 300)
                    
                    // Preview label
                    HStack {
                        Text("Preview")
                            .font(.headline)
                            .foregroundColor(.textPrimary)
                        Spacer()
                    }
                    .padding()
                    .background(Color.cardBackground)
                    
                    // Preview
                    HTMLPreview(
                        htmlContent: htmlCode,
                        cssContent: cssCode.isEmpty ? nil : cssCode,
                        jsContent: jsCode.isEmpty ? nil : jsCode
                    )
                    .background(Color.appBackground)
                    .padding(.bottom, 140) // Make room for floating button + tab bar
                }
                
                // Floating completion button
                VStack(spacing: 0) {
                    Divider()
                        .background(Color.appBorder)
                    
                    HStack {
                        Spacer()
                        
                        StyledActionButton(
                            title: "Complete Lesson",
                            style: .complete
                        ) {
                            // Save code first
                            saveCurrentCode()
                            
                            // Wait a moment for save to complete, then mark as complete
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                progressService.completeLesson(lesson)
                                
                                // Dismiss after celebration starts
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    dismiss()
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 50) // Account for tab bar
                    .background(Color.cardBackground.opacity(0.95))
                }
            }
            .background(Color.appBackground)
            .ignoresSafeArea()
        }
    }
}

