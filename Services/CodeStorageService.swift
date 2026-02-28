import Foundation
import Combine

enum CodeLanguage: String {
    case html = "html"
    case css = "css"
    case javascript = "js"
}

@MainActor
protocol CodeStorage {
    func save(code: String, for lessonId: Int, language: CodeLanguage)
    func load(for lessonId: Int, language: CodeLanguage) -> String?
    func reset(for lessonId: Int, to starterCode: (html: String, css: String?, js: String?))
    func hasCode(for lessonId: Int) -> Bool
    func clearAll()
    func markAsEdited(for lessonId: Int)
    func clearEditedFlag(for lessonId: Int)
    func hasBeenEdited(for lessonId: Int) -> Bool
    func saveStarterHash(hash: Int, for lessonId: Int)
    func loadStarterHash(for lessonId: Int) -> Int?
}

@MainActor
class CodeStorageService: CodeStorage {
    static let shared = CodeStorageService()

    private let defaults = UserDefaults.standard
    private var saveTimers: [String: AnyCancellable] = [:]

    private init() {}

    // MARK: - Public Methods

    func save(code: String, for lessonId: Int, language: CodeLanguage) {
        let key = makeKey(lessonId: lessonId, language: language)
        defaults.set(code, forKey: key)
        defaults.set(Date(), forKey: makeTimestampKey(lessonId: lessonId))
    }

    func load(for lessonId: Int, language: CodeLanguage) -> String? {
        let key = makeKey(lessonId: lessonId, language: language)
        return defaults.string(forKey: key)
    }

    func reset(for lessonId: Int, to starterCode: (html: String, css: String?, js: String?)) {
        save(code: starterCode.html, for: lessonId, language: .html)
        save(code: starterCode.css ?? "", for: lessonId, language: .css)
        save(code: starterCode.js ?? "", for: lessonId, language: .javascript)
    }

    func hasCode(for lessonId: Int) -> Bool {
        let htmlKey = makeKey(lessonId: lessonId, language: .html)
        return defaults.string(forKey: htmlKey) != nil
    }

    func clearAll() {
        let keys = defaults.dictionaryRepresentation().keys
        for key in keys where key.hasPrefix("lesson_") {
            defaults.removeObject(forKey: key)
        }
    }

    func lastEditDate(for lessonId: Int) -> Date? {
        let key = makeTimestampKey(lessonId: lessonId)
        return defaults.object(forKey: key) as? Date
    }

    func autoSave(code: String, for lessonId: Int, language: CodeLanguage, delay: TimeInterval = 1.0) {
        let timerKey = "\(lessonId)_\(language.rawValue)"
        saveTimers[timerKey]?.cancel()
        saveTimers[timerKey] = Just(())
            .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.save(code: code, for: lessonId, language: language)
            }
    }

    // MARK: - Starter Code & Edit Tracking
    
    func markAsEdited(for lessonId: Int) {
        let key = makeEditedKey(lessonId: lessonId)
        defaults.set(true, forKey: key)
    }
    
    func clearEditedFlag(for lessonId: Int) {
        let key = makeEditedKey(lessonId: lessonId)
        defaults.removeObject(forKey: key)
    }
    
    func hasBeenEdited(for lessonId: Int) -> Bool {
        let key = makeEditedKey(lessonId: lessonId)
        return defaults.bool(forKey: key)
    }
    
    func saveStarterHash(hash: Int, for lessonId: Int) {
        let key = makeHashKey(lessonId: lessonId)
        defaults.set(hash, forKey: key)
    }
    
    func loadStarterHash(for lessonId: Int) -> Int? {
        let key = makeHashKey(lessonId: lessonId)
        return defaults.object(forKey: key) as? Int
    }
    
    // MARK: - Private Helpers

    private func makeKey(lessonId: Int, language: CodeLanguage) -> String {
        return "lesson_\(lessonId)_\(language.rawValue)"
    }

    private func makeTimestampKey(lessonId: Int) -> String {
        return "lesson_\(lessonId)_timestamp"
    }

    private func makeEditedKey(lessonId: Int) -> String {
        return "lesson_\(lessonId)_edited"
    }
    
    private func makeHashKey(lessonId: Int) -> String {
        return "lesson_\(lessonId)_starterHash"
    }
}
