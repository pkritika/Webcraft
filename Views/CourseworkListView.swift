//
//  CourseworkListView.swift
//  WebCraft
//
//  Shows one card per module. Tapping a module opens ModuleDetailView with its sub-lessons.
//

import SwiftUI

struct CourseworkListView: View {
    @EnvironmentObject var progressService: ProgressService

    // One accent colour per module (in order), mirroring the assessment palette
    private let moduleColors: [String] = [
        "#6366F1", // Module 1 — indigo
        "#EC4899", // Module 2 — pink
        "#0E7490", // Module 3 — teal
        "#F59E0B", // Module 4 — amber
        "#065F46", // Module 5 — emerald
        "#5B21B6", // Module 6 — violet
        "#1E40AF", // Module 7 — blue
    ]

    private let moduleIcons: [String] = [
        "globe",
        "link.circle.fill",
        "paintbrush.fill",
        "photo.fill",
        "tablecells.fill",
        "rectangle.3.group.fill",
        "envelope.fill",
    ]

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
            "Module 1: The Web & HTML Basics": "HTML Basics",
            "Module 2: Links, Colors & Fonts": "Links, Colors & Fonts",
            "Module 3: Introduction to CSS": "Introduction to CSS",
            "Module 4: Images & Media": "Images & Media",
            "Module 5: Imagemaps, Media & Tables": "Imagemaps & Tables",
            "Module 6: Advanced CSS": "Advanced CSS",
            "Module 7: HTML Forms": "HTML Forms",
        ]
        return map[moduleTitle] ?? moduleTitle
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    // ── Header ─────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Coursework")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.textPrimary)

                        Text("Master web development step by step")
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // ── Module cards ───────────────────────────────────
                    VStack(spacing: 12) {
                        ForEach(Array(moduleTitles.enumerated()), id: \.element) { idx, moduleTitle in
                            let moduleLessons = lessons(for: moduleTitle)
                            let displayTitle  = displayName(for: moduleTitle)
                            let accentHex     = moduleColors[min(idx, moduleColors.count - 1)]
                            let icon          = moduleIcons[min(idx, moduleIcons.count - 1)]

                            NavigationLink(destination:
                                ModuleDetailView(
                                    moduleDisplayTitle: displayTitle,
                                    lessons: moduleLessons
                                )
                                .environmentObject(progressService)
                            ) {
                                ModuleRowCard(
                                    title: displayTitle,
                                    lessons: moduleLessons,
                                    accentHex: accentHex,
                                    icon: icon,
                                    progressService: progressService
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .padding(.top, 16)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Module Row Card

private struct ModuleRowCard: View {
    let title: String
    let lessons: [Lesson]
    let accentHex: String
    let icon: String
    let progressService: ProgressService

    private var accent: Color { Color(hex: accentHex) }

    private var completedCount: Int {
        lessons.filter { progressService.isLessonCompleted($0) }.count
    }

    private var progressFraction: CGFloat {
        lessons.isEmpty ? 0 : CGFloat(completedCount) / CGFloat(lessons.count)
    }

    private var isAllDone: Bool { completedCount == lessons.count }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {

            // ── Icon circle ───────────────────────────────
            ZStack {
                Circle()
                    .fill(accent.opacity(isAllDone ? 0.25 : 0.12))
                    .frame(width: 60, height: 60)

                Circle()
                    .stroke(accent.opacity(0.3), lineWidth: 1)
                    .frame(width: 60, height: 60)

                if isAllDone {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(accent)
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(accent)
                }
            }
            .frame(width: 60, height: 60)

            // ── Text + progress ───────────────────────────
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)

                Text("\(lessons.count) lessons · \(completedCount) done")
                    .font(.system(size: 13))
                    .foregroundColor(.textSecondary)

                // Mini progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.08))
                            .frame(height: 4)
                        Capsule()
                            .fill(isAllDone ? Color(hex: "34D399") : accent)
                            .frame(width: geo.size.width * progressFraction, height: 4)
                            .animation(.spring(), value: completedCount)
                    }
                }
                .frame(height: 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // ── Status ────────────────────────────────────
            VStack(spacing: 0) {
                if isAllDone {
                    VStack(spacing: 4) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 20))
                            .foregroundColor(accent)
                        Text("Done")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(accent)
                    }
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.textTertiary)
                }
            }
            .frame(width: 44, alignment: .center)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isAllDone
                        ? accent.opacity(0.3)
                        : Color.white.opacity(0.06),
                    lineWidth: 1
                )
        )
        .shadow(
            color: isAllDone
                ? accent.opacity(0.15)
                : Color.black.opacity(0.1),
            radius: isAllDone ? 12 : 8,
            x: 0,
            y: isAllDone ? 6 : 4
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
    }
}
