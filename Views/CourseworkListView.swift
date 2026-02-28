//
//  CourseworkListView.swift
//  WebCraft
//
//  Shows one card per module. Tapping a module opens ModuleDetailView with its sub-lessons.
//

import SwiftUI

struct CourseworkListView: View {
    @EnvironmentObject var progressService: ProgressService

    // Ordered unique module titles
    private var moduleTitles: [String] {
        var seen = Set<String>()
        return LessonContent.allLessons
            .filter { !$0.isAssessment }
            .compactMap { lesson -> String? in
                let title = lesson.moduleTitle
                guard !seen.contains(title) else { return nil }
                seen.insert(title)
                return title
            }
    }

    private func lessons(for moduleTitle: String) -> [Lesson] {
        LessonContent.allLessons.filter { !$0.isAssessment && $0.moduleTitle == moduleTitle }
    }

    // Human-friendly display name for each moduleTitle
    private func displayName(for moduleTitle: String) -> String {
        let map: [String: String] = [
            "Module 1: The Web & HTML Basics": "Introduction",
            "Module 2: Links, Colors & Fonts": "Links, Colors & Fonts",
            "Module 3: Introduction to CSS": "Introduction to CSS",
            "Module 4: Images & Media": "Images & Media",
            "Module 5: Imagemaps, Media & Tables": "Imagemaps, Media & Tables",
            "Module 6: Advanced CSS": "Advanced CSS",
            "Module 7: HTML Forms": "HTML Forms",
        ]
        return map[moduleTitle] ?? moduleTitle
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Title
                    Text("Coursework")
                        .fontRounded(size: 32, weight: .bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    // Module cards
                    VStack(spacing: 16) {
                        ForEach(moduleTitles, id: \.self) { moduleTitle in
                            let moduleLessons = lessons(for: moduleTitle)
                            let displayTitle  = displayName(for: moduleTitle)
                            NavigationLink(destination:
                                ModuleDetailView(
                                    moduleDisplayTitle: displayTitle,
                                    lessons: moduleLessons
                                )
                                .environmentObject(progressService)
                            ) {
                                ModuleRowCard(
                                    title: displayTitle,
                                    subtitle: moduleTitle,
                                    lessons: moduleLessons,
                                    progressService: progressService
                                )
                            }
                            .buttonStyle(.scale)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
            .background(PremiumBackground())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Module Row Card

private struct ModuleRowCard: View {
    let title: String
    let subtitle: String
    let lessons: [Lesson]
    let progressService: ProgressService

    private var completedCount: Int {
        lessons.filter { progressService.isLessonCompleted($0) }.count
    }

    private var progressFraction: CGFloat {
        lessons.isEmpty ? 0 : CGFloat(completedCount) / CGFloat(lessons.count)
    }

    private var isAllDone: Bool { completedCount == lessons.count }

    var body: some View {
        HStack(spacing: 16) {
            // Left accent / icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: "818CF8").opacity(0.18))
                    .frame(width: 56, height: 56)
                Image(systemName: isAllDone ? "checkmark.seal.fill" : "books.vertical.fill")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(isAllDone ? Color(hex: "34D399") : Color(hex: "818CF8"))
            }

            // Text block
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .fontRounded(size: 18, weight: .bold)
                    .foregroundColor(.white)

                Text("\(lessons.count) lessons · \(completedCount) done")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.45))

                // Mini progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.1))
                            .frame(height: 4)
                        Capsule()
                            .fill(isAllDone ? Color(hex: "34D399") : Color(hex: "818CF8"))
                            .frame(width: geo.size.width * progressFraction, height: 4)
                    }
                }
                .frame(height: 4)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.3))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color(hex: "818CF8").opacity(0.2), lineWidth: 1)
                )
        )
    }
}
