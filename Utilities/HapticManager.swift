//
//  HapticManager.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import UIKit

enum HapticType {
    case success
    case error
    case warning
    case light
    case medium
    case heavy
    case selection
}

@MainActor
class HapticManager {
    static let shared = HapticManager()
    
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    private let selectionGenerator = UISelectionFeedbackGenerator()
    
    private init() {
        // Prepare generators for lower latency
        notificationGenerator.prepare()
        impactLight.prepare()
        impactMedium.prepare()
        impactHeavy.prepare()
        selectionGenerator.prepare()
    }
    
    func trigger(_ type: HapticType) {
        switch type {
        case .success:
            notificationGenerator.notificationOccurred(.success)
            notificationGenerator.prepare()
        case .error:
            notificationGenerator.notificationOccurred(.error)
            notificationGenerator.prepare()
        case .warning:
            notificationGenerator.notificationOccurred(.warning)
            notificationGenerator.prepare()
        case .light:
            impactLight.impactOccurred()
            impactLight.prepare()
        case .medium:
            impactMedium.impactOccurred()
            impactMedium.prepare()
        case .heavy:
            impactHeavy.impactOccurred()
            impactHeavy.prepare()
        case .selection:
            selectionGenerator.selectionChanged()
            selectionGenerator.prepare()
        }
    }
    
    // Special pattern for celebrations
    func triggerCelebration() {
        trigger(.heavy)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.trigger(.medium)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.trigger(.light)
        }
    }
}
