//
//  ModuleDetailView.swift
//  WebCraft
//
//  Shows the sub-lessons inside a module. Tap any unlocked sub-lesson to open LearnView.
//

import SwiftUI

struct ModuleDetailView: View {
    let moduleDisplayTitle: String
    let lessons: [Lesson]

    @EnvironmentObject var progressService: ProgressService

    // Icons per position in the module
    private let icons = [
        "wifi",
        "text.book.closed.fill",
        "chevron.left.forwardslash.chevron.right",
        "map.fill",
        "checkmark.circle.fill"
    ]

    private let accentColors: [Color] = [
        Color(hex: "818CF8"),
        Color(hex: "34D399"),
        Color(hex: "F472B6"),
        Color(hex: "FBBF24"),
        Color(hex: "60A5FA")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // ── Module Header ────────────────────────────────────
                VStack(alignment: .leading, spacing: 8) {
                    Text("Module")
                        .font(.system(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Color(hex: "818CF8").opacity(0.9))

                    Text(moduleDisplayTitle)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.textPrimary)

                    let completedCount = lessons.filter { progressService.isLessonCompleted($0) }.count
                    Text("\(completedCount) of \(lessons.count) completed")
                        .font(.system(size: 13))
                        .foregroundColor(.textPrimary.opacity(0.5))

                    // Segmented progress bar — one pill per lesson
                    HStack(spacing: 4) {
                        ForEach(Array(lessons.enumerated()), id: \.offset) { idx, lesson in
                            let isDone      = progressService.isLessonCompleted(lesson)
                            let isNext      = !isDone && progressService.isLessonUnlocked(lesson)
                            Capsule()
                                .fill(
                                    isDone  ? Color(hex: "10B981") :    // green — done
                                    isNext  ? Color(hex: "6366F1") :    // indigo — next up
                                              Color.textPrimary.opacity(0.12) // dim — locked
                                )
                                .frame(height: 7)
                                .animation(.spring(response: 0.4), value: isDone)
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                .padding(.bottom, 28)

                // ── Sub-lesson List ──────────────────────────────────
                VStack(spacing: 0) {
                    ForEach(Array(lessons.enumerated()), id: \.element.id) { idx, lesson in
                        let isLocked    = !progressService.isLessonUnlocked(lesson)
                        let isCompleted = progressService.isLessonCompleted(lesson)
                        let accent      = accentColors[min(idx, accentColors.count - 1)]
                        let icon        = icons[min(idx, icons.count - 1)]

                        if isLocked {
                            SubLessonRow(
                                index: idx,
                                lesson: lesson,
                                icon: icon,
                                accent: accent,
                                isLocked: true,
                                isCompleted: false
                            )
                            .disabled(true)
                        } else {
                            NavigationLink(destination: LearnView(lesson: lesson)) {
                                SubLessonRow(
                                    index: idx,
                                    lesson: lesson,
                                    icon: icon,
                                    accent: accent,
                                    isLocked: false,
                                    isCompleted: isCompleted
                                )
                            }
                            .buttonStyle(.plain)
                        }

                        if idx < lessons.count - 1 {
                            // Connector line between rows
                            HStack {
                                Spacer().frame(width: 24 + 20 + 14) // align with icon centre
                                Rectangle()
                                    .fill(isCompleted ? accent.opacity(0.5) : Color.textPrimary.opacity(0.08))
                                    .frame(width: 2, height: 20)
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBackground, for: .navigationBar)
    }
}

// MARK: - Sub-lesson Row

private struct SubLessonRow: View {
    let index: Int
    let lesson: Lesson
    let icon: String
    let accent: Color
    let isLocked: Bool
    let isCompleted: Bool

    var body: some View {
        HStack(spacing: 16) {
            // Icon badge
            ZStack {
                Circle()
                    .fill(isCompleted ? accent : (isLocked ? Color.textPrimary.opacity(0.08) : accent.opacity(0.18)))
                    .frame(width: 48, height: 48)

                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.appBackground)
                } else if isLocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.textPrimary.opacity(0.3))
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(accent)
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 3) {
                Text(lesson.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isLocked ? .textPrimary.opacity(0.4) : .textPrimary)

                Text(lesson.description)
                    .font(.system(size: 12))
                    .foregroundColor(.textPrimary.opacity(isLocked ? 0.3 : 0.6))
                    .lineLimit(2)
            }

            Spacer()

            // XP badge or chevron
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(accent)
                    .font(.system(size: 20))
            } else if !isLocked {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("+\(lesson.xpReward) XP")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(accent)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.textPrimary.opacity(0.4))
                }
            } else {
                Image(systemName: "lock.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.textPrimary.opacity(0.2))
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .contentShape(Rectangle())
    }
}
