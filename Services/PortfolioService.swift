import Foundation
import Combine

enum PortfolioError: LocalizedError {
    case encodingFailed
    case decodingFailed
    case saveFailed
    case exportFailed

    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Failed to encode portfolio data"
        case .decodingFailed:
            return "Failed to decode portfolio data"
        case .saveFailed:
            return "Failed to save portfolio"
        case .exportFailed:
            return "Failed to export portfolio files"
        }
    }
}

@MainActor
class PortfolioService: ObservableObject {
    static let shared = PortfolioService()

    @Published var portfolio: PortfolioState
    @Published var hasUnsavedChanges = false
    @Published var isSaving = false
    @Published var lastSaveTime: Date?
    @Published var lastError: PortfolioError?

    private let portfolioKey = "userPortfolio"
    private let defaults = UserDefaults.standard
    private var saveCancellable: AnyCancellable?
    private var isResetting = false

    private init() {
        if let data = defaults.data(forKey: portfolioKey),
           let decoded = try? JSONDecoder().decode(PortfolioState.self, from: data) {
            self.portfolio = decoded
            self.lastSaveTime = portfolio.lastModified
        } else {
            self.portfolio = .empty
        }
        setupAutoSave()
    }

    private func setupAutoSave() {
        saveCancellable = $portfolio
            .dropFirst()
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self, !self.isResetting else { return }
                self.hasUnsavedChanges = true
                self.autoSave()
            }
    }

    func savePortfolio() {
        guard !isResetting else { return }
        isSaving = true
        portfolio.lastModified = Date()

        do {
            let encoded = try JSONEncoder().encode(portfolio)
            defaults.set(encoded, forKey: portfolioKey)
            lastSaveTime = Date()
            hasUnsavedChanges = false
            lastError = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isSaving = false
            }
        } catch {
            lastError = .saveFailed
            isSaving = false
            print("Portfolio save error: \(error.localizedDescription)")
        }
    }

    private func autoSave() {
        guard !isResetting else { return }
        portfolio.lastModified = Date()
        do {
            let encoded = try JSONEncoder().encode(portfolio)
            defaults.set(encoded, forKey: portfolioKey)
            lastSaveTime = Date()
            hasUnsavedChanges = false
            lastError = nil
        } catch {
            lastError = .saveFailed
            print("Portfolio auto-save error: \(error.localizedDescription)")
        }
    }

    func loadPortfolio() -> PortfolioState {
        if let data = defaults.data(forKey: portfolioKey),
           let decoded = try? JSONDecoder().decode(PortfolioState.self, from: data) {
            return decoded
        }
        return .empty
    }

    func resetPortfolio() {
        isResetting = true
        portfolio = .empty
        defaults.removeObject(forKey: portfolioKey)
        defaults.removeObject(forKey: "portfolioOwnerId")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isResetting = false
        }
    }

    func markSectionComplete(_ section: String) {
        portfolio.completedSections.insert(section)
        savePortfolio()
    }

    func exportPortfolio() -> (html: String, css: String, js: String) {
        var exportHTML = portfolio.htmlCode
        if !exportHTML.contains("<link rel=\"stylesheet\" href=\"styles.css\">") {
            exportHTML = exportHTML.replacingOccurrences(of: "</head>", with: "    <link rel=\"stylesheet\" href=\"styles.css\">\n</head>")
        }
        if !exportHTML.contains("<script src=\"script.js\">") {
            exportHTML = exportHTML.replacingOccurrences(of: "</body>", with: "    <script src=\"script.js\"></script>\n</body>")
        }
        return (html: exportHTML, css: portfolio.cssCode, js: portfolio.jsCode)
    }

    func getCompletionPercentage(totalSections: Int) -> Double {
        let completed = Double(portfolio.completedSections.count)
        return (completed / Double(totalSections)) * 100
    }
}
