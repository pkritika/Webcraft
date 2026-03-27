import SwiftUI

struct AssessmentListView: View {
    @EnvironmentObject var portfolioService: PortfolioService

    private var completedCount: Int {
        PortfolioAssessment.allAssessments.filter { assessment in
            portfolioService.portfolio.completedSections.contains(assessment.title)
        }.count
    }

    private var totalCount: Int {
        PortfolioAssessment.allAssessments.count
    }

    private var completionPercentage: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount)
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // Header Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Assessments")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.textPrimary)

                        Text("Build your portfolio section by section")
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // Progress Card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .center, spacing: 12) {
                            // Progress Circle
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.1), lineWidth: 4)
                                    .frame(width: 60, height: 60)

                                Circle()
                                    .trim(from: 0, to: completionPercentage)
                                    .stroke(
                                        LinearGradient(
                                            colors: [Color.appPrimary, Color.appSecondary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                                    )
                                    .frame(width: 60, height: 60)
                                    .rotationEffect(.degrees(-90))

                                VStack(spacing: 0) {
                                    Text("\(completedCount)")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.textPrimary)
                                    Text("of \(totalCount)")
                                        .font(.system(size: 10))
                                        .foregroundColor(.textSecondary)
                                }
                            }

                            // Progress Info
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Your Progress")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.textPrimary)

                                Text(completedCount == totalCount ? "All sections completed! 🎉" : "\(totalCount - completedCount) section\(totalCount - completedCount == 1 ? "" : "s") remaining")
                                    .font(.system(size: 13))
                                    .foregroundColor(.textSecondary)
                                    .lineLimit(2)

                                // Progress bar
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.white.opacity(0.08))
                                            .frame(height: 6)

                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(
                                                LinearGradient(
                                                    colors: [Color.appPrimary, Color.appSecondary],
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )
                                            .frame(width: geometry.size.width * completionPercentage, height: 6)
                                    }
                                }
                                .frame(height: 6)
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)

                    // Section Header
                    HStack {
                        Text("All Sections")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.textPrimary)

                        Spacer()

                        Text("\(completedCount)/\(totalCount)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // Assessment Cards
                    VStack(spacing: 12) {
                        ForEach(PortfolioAssessment.allAssessments) { assessment in
                            NavigationLink(destination: AssessmentEditorView(assessment: assessment)) {
                                AssessmentSectionCard(
                                    assessment: assessment,
                                    isCompleted: portfolioService.portfolio.completedSections.contains(assessment.title)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
                .padding(.top, 16)
            }
            .background(Color.appBackground.ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

struct AssessmentSectionCard: View {
    let assessment: PortfolioAssessment
    let isCompleted: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Icon circle with fixed width
            ZStack {
                Circle()
                    .fill(Color(hex: assessment.color).opacity(isCompleted ? 0.25 : 0.12))
                    .frame(width: 60, height: 60)

                Circle()
                    .stroke(Color(hex: assessment.color).opacity(0.3), lineWidth: 1)
                    .frame(width: 60, height: 60)

                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(hex: assessment.color))
                } else {
                    Image(systemName: assessment.icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color(hex: assessment.color))
                }
            }
            .frame(width: 60, height: 60)

            // Text content with flexible width
            VStack(alignment: .leading, spacing: 6) {
                Text(assessment.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)

                Text(assessment.description)
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Status indicator with fixed width
            VStack(spacing: 0) {
                if isCompleted {
                    VStack(spacing: 4) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Color(hex: assessment.color))

                        Text("Done")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(hex: assessment.color))
                    }
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .semibold))
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
                    isCompleted
                        ? Color(hex: assessment.color).opacity(0.3)
                        : Color.white.opacity(0.06),
                    lineWidth: 1
                )
        )
        .shadow(
            color: isCompleted
                ? Color(hex: assessment.color).opacity(0.15)
                : Color.black.opacity(0.1),
            radius: isCompleted ? 12 : 8,
            x: 0,
            y: isCompleted ? 6 : 4
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(assessment.title). \(assessment.description)")
        .accessibilityHint(isCompleted ? "Completed. Double tap to review." : "Not completed. Double tap to start.")
    }
}

#Preview {
    AssessmentListView()
        .environmentObject(PortfolioService.shared)
}
