//
//  PortfolioState.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import Foundation

struct PortfolioState: Codable, Equatable {
    var htmlCode: String
    var cssCode: String
    var jsCode: String
    var lastModified: Date
    var completedSections: Set<String>
    
    // User personalization
    var userName: String
    var userTitle: String
    var userBio: String
    var userEmail: String
    var socialLinks: [String: String]
    var projects: [PortfolioProject]
    var skills: [String]
    
    static var empty: PortfolioState {
        PortfolioState(
            htmlCode: """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Portfolio</title>
                <link rel="stylesheet" href="styles.css">
            </head>
            <body>
                <!-- Your portfolio sections will be added here -->
                
                <script src="script.js"></script>
            </body>
            </html>
            """,
            cssCode: """
            /* Your CSS styles will be added here */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                line-height: 1.6;
                color: #333;
            }
            """,
            jsCode: "// Your JavaScript code will be added here\n",
            lastModified: Date(),
            completedSections: [],
            userName: "Your Name",
            userTitle: "Web Developer",
            userBio: "A passionate developer learning to build amazing websites.",
            userEmail: "your.email@example.com",
            socialLinks: [:],
            projects: [],
            skills: []
        )
    }
}

struct PortfolioProject: Codable, Equatable, Identifiable {
    let id: UUID
    var title: String
    var description: String
    var technologies: [String]
    var liveUrl: String?
    var githubUrl: String?
    
    init(id: UUID = UUID(), title: String, description: String, technologies: [String], liveUrl: String? = nil, githubUrl: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.technologies = technologies
        self.liveUrl = liveUrl
        self.githubUrl = githubUrl
    }
}
