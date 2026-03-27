# Webcraft

Webcraft is an interactive, educational iOS/iPadOS application developed with SwiftUI (structured as a Swift Playgrounds `.swiftpm` project). Its primary objective is to teach users web development fundamentals—like HTML and CSS—through hands-on lessons, interactive coding assessments, and portfolio-building.

## Core Features

- **Interactive Coding & Real-time Preview**: A built-in code editor paired with an `HTMLPreview` renderer allows users to write HTML/CSS and instantly see the visual web page output without leaving the app.
- **Guided Coursework**: A structured curriculum containing modules and lessons to gently guide beginners sequentially through fundamental web concepts.
- **Coding Assessments**: Interactive challenges designed for users to actively write code to solve specific problems and validate their understanding.
- **Portfolio Building**: By completing modules and assessments, users cumulatively build their own personal portfolio website applying the skills they acquire.

## Architecture

Webcraft employs an MVVM-inspired architecture, heavily utilizing SwiftUI for its user interface and centralized `ObservableObject` services for application state.

- **`ProgressService`**: Tracks user experience points (XP), lessons completed, and dispatches celebration animations upon finishing tasks.
- **`PortfolioService`**: Handles the persistence and active management of the user's ongoing cumulative portfolio project.
- **`LocalAuthService`**: Provides secure local, on-device user authentication and profile management.
- **`CodeStorageService`**: Persistently saves user-written code modules locally between application sessions.
- **`TTSService`**: A comprehensive Text-to-Speech service aimed at accessibility, enabling users to hear lesson instructions spoken out loud.

## Development

- **SwiftUI**: Powers all visual components, layouts, components, and animations across the application.
- **Swift Playgrounds**: Formatted explicitly as a `.swiftpm` package for seamless plug-and-play local development and rapid iteration on both macOS and iPadOS.