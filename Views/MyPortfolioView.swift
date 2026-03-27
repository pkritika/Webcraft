//
//  MyPortfolioView.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import SwiftUI

struct MyPortfolioView: View {
    @EnvironmentObject var portfolioService: PortfolioService
    @EnvironmentObject var progressService: ProgressService
    @State private var showExportSheet = false
    @State private var showShareSheet = false
    @State private var showResetConfirmation = false
    @State private var exportedFileURLs: [URL] = []
    @State private var showExportError = false
    @State private var exportErrorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                // Full portfolio preview - acts as the background/main content
                HTMLPreview(
                    htmlContent: portfolioService.portfolio.htmlCode,
                    cssContent: portfolioService.portfolio.cssCode,
                    jsContent: portfolioService.portfolio.jsCode
                )
                .edgesIgnoringSafeArea(.all) // Extend to all edges
                
                // Floating Menu Button
                Menu {
                    Button(action: handleExport) {
                        Label("Export Files", systemImage: "square.and.arrow.down")
                    }

                    Button(action: { showShareSheet = true }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }

                    Divider()

                    Button(role: .destructive, action: { showResetConfirmation = true }) {
                        Label("Reset Portfolio", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 1)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .accessibilityLabel("Portfolio options")
                .accessibilityHint("Export, share, or reset your portfolio")
                .padding(.top, 10) // Small padding from top safe area
                .padding(.trailing, 16)
            }
            .navigationBarHidden(true)
            .background(Color.appBackground.ignoresSafeArea())
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(items: [generateShareText()])
            }
            .sheet(isPresented: $showExportSheet) {
                ShareSheet(items: exportedFileURLs)
            }
            .alert("Reset Portfolio?", isPresented: $showResetConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    handleReset()
                }
            } message: {
                Text("This will erase all your portfolio code and sections. This action cannot be undone.")
            }
            .alert("Export Failed", isPresented: $showExportError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(exportErrorMessage)
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private var portfolioStatsHeader: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                StatCard(
                    title: "Sections",
                    value: "\(portfolioService.portfolio.completedSections.count)/21",
                    icon: "checkmark.square.fill",
                    color: .appPrimary
                )
                
                StatCard(
                    title: "Completion",
                    value: "\(Int(portfolioService.getCompletionPercentage(totalSections: 21)))%",
                    icon: "chart.bar.fill",
                    color: .appSuccess
                )
                
                StatCard(
                    title: "Lines",
                    value: "\(countLines())",
                    icon: "doc.text.fill",
                    color: .appSecondary
                )
            }
            .padding()
            
            if portfolioService.portfolio.completedSections.count < 21 {
                HStack {
                    Text("Continue building to add more sections")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                    
                    Spacer()
                    
                    NavigationLink(destination: LessonListView()) {
                        Text("Continue Building →")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.appPrimary)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .background(Color.cardBackground)
    }
    
    private func countLines() -> Int {
        let html = portfolioService.portfolio.htmlCode.split(separator: "\n").count
        let css = portfolioService.portfolio.cssCode.split(separator: "\n").count
        let js = portfolioService.portfolio.jsCode.split(separator: "\n").count
        return html + css + js
    }
    
    private func handleExport() {
        do {
            HapticManager.shared.trigger(.success)
            let files = portfolioService.exportPortfolio()

            // Create temporary files
            let fileManager = FileManager.default
            let tempDir = fileManager.temporaryDirectory.appendingPathComponent("WebCraft_Export", isDirectory: true)
            try fileManager.createDirectory(at: tempDir, withIntermediateDirectories: true)

            let htmlURL = tempDir.appendingPathComponent("index.html")
            let cssURL = tempDir.appendingPathComponent("styles.css")
            let jsURL = tempDir.appendingPathComponent("script.js")

            try files.html.write(to: htmlURL, atomically: true, encoding: .utf8)
            try files.css.write(to: cssURL, atomically: true, encoding: .utf8)
            try files.js.write(to: jsURL, atomically: true, encoding: .utf8)

            // Show share sheet with actual files
            exportedFileURLs = [htmlURL, cssURL, jsURL]
            showExportSheet = true
        } catch {
            exportErrorMessage = "Could not export files: \(error.localizedDescription)"
            showExportError = true
            HapticManager.shared.trigger(.error)
        }
    }
    
    private func handleReset() {
        HapticManager.shared.trigger(.warning)
        // Show confirmation alert (to be added)
        portfolioService.resetPortfolio()
    }
    
    private func generateShareText() -> String {
        return """
        Check out my portfolio website!
        
        I built this using WebCraft while learning HTML, CSS, and JavaScript.
        
        Completed: \(portfolioService.portfolio.completedSections.count)/21 sections
        """
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .bold()
                .foregroundColor(.textPrimary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.surfaceBackground)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// Share sheet wrapper
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview("My Portfolio") {
    MyPortfolioView()
        .environmentObject(PortfolioService.shared)
        .environmentObject(ProgressService.shared)
}
