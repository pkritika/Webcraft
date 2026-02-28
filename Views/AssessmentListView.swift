import SwiftUI

struct AssessmentListView: View {
    @EnvironmentObject var portfolioService: PortfolioService
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Assessments")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal)
                    .padding(.bottom, 4)
                
                Text("Build your portfolio section by section")
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(PortfolioAssessment.allAssessments) { assessment in
                            NavigationLink(destination: AssessmentEditorView(assessment: assessment)) {
                                AssessmentSectionCard(
                                    assessment: assessment,
                                    isCompleted: portfolioService.portfolio.completedSections.contains(assessment.title)
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
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
        HStack(spacing: 16) {
            // Icon circle
            ZStack {
                Circle()
                    .fill(Color(hex: assessment.color).opacity(isCompleted ? 0.3 : 0.15))
                    .frame(width: 56, height: 56)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: assessment.color))
                } else {
                    Image(systemName: assessment.icon)
                        .font(.system(size: 22))
                        .foregroundColor(Color(hex: assessment.color))
                }
            }
            
            // Text
            VStack(alignment: .leading, spacing: 4) {
                Text(assessment.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.textPrimary)
                
                Text(assessment.description)
                    .font(.system(size: 13))
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            // Status
            if isCompleted {
                Text("Done")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(hex: assessment.color))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color(hex: assessment.color).opacity(0.15))
                    .clipShape(Capsule())
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
