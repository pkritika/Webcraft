//
//  ConsoleMessage.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import Foundation

enum ConsoleMessageType {
    case log
    case error
    case warn
    case info
}

struct ConsoleMessage: Identifiable, Equatable {
    let id = UUID()
    let type: ConsoleMessageType
    let message: String
    let timestamp: Date
    
    init(type: ConsoleMessageType, message: String) {
        self.type = type
        self.message = message
        self.timestamp = Date()
    }
}
