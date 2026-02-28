//
//  PortfolioLessonTemplates.swift
//  WebCraft
//
//  Created by Kritika Pant on 2/2/26.
//

import Foundation

struct PortfolioTemplate {
    let htmlSnippet: String
    let cssSnippet: String
    let jsSnippet: String
    let insertion: InsertionStrategy
}

enum InsertionStrategy {
    case replaceBody  // Replace <!-- Your portfolio sections will be added here -->
    case appendToBody  // Add before </body>
    case appendToCSS  // Add to end of CSS
    case appendToJS   // Add to end of JS
}

class PortfolioLessonTemplates {
    
    // ═══════════════════════════════════════════
    // PHASE 1 – HTML FOUNDATIONS (Lessons 1-5)
    // ═══════════════════════════════════════════
    
    // MARK: - Lesson 1: Your First Web Page
    static let lesson1Template = PortfolioTemplate(
        htmlSnippet: """
        <header id="home">
            <h1>My Portfolio</h1>
            <p>Welcome to my very first web page!</p>
        </header>
        """,
        cssSnippet: """
        
        /* Base styles from Lesson 1 */
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        
        header {
            text-align: center;
            padding: 80px 20px;
            background: #0d1117;
            color: #c9d1d9;
        }
        
        header h1 {
            font-size: 2.5rem;
            color: #58a6ff;
            margin-bottom: 10px;
        }
        """,
        jsSnippet: "",
        insertion: .replaceBody
    )
    
    // MARK: - Lesson 2: Text & Paragraphs
    static let lesson2Template = PortfolioTemplate(
        htmlSnippet: """
        
        <section id="about">
            <h2>About Me</h2>
            <p>I'm learning to build websites with <strong>HTML</strong>, <strong>CSS</strong>, and <strong>JavaScript</strong>.</p>
            <p>This portfolio showcases what I've learned in each lesson.</p>
        </section>
        """,
        cssSnippet: """
        
        /* About section from Lesson 2 */
        #about {
            padding: 60px 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        
        #about h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #333;
        }
        
        #about p {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 15px;
        }
        """,
        jsSnippet: "",
        insertion: .appendToBody
    )
    
    // MARK: - Lesson 3: Lists & Structure
    static let lesson3Template = PortfolioTemplate(
        htmlSnippet: """
        
        <section id="skills">
            <h2>Skills I'm Learning</h2>
            <ul>
                <li>HTML – Page structure</li>
                <li>CSS – Visual styling</li>
                <li>JavaScript – Interactivity</li>
            </ul>
        </section>
        """,
        cssSnippet: """
        
        /* Skills list from Lesson 3 */
        #skills {
            padding: 60px 20px;
            background: #f8f9fa;
        }
        
        #skills h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 30px;
            color: #333;
        }
        
        #skills ul {
            max-width: 600px;
            margin: 0 auto;
            list-style: none;
            padding: 0;
        }
        
        #skills li {
            padding: 12px 20px;
            margin-bottom: 10px;
            background: white;
            border-radius: 8px;
            font-size: 1.1rem;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        }
        """,
        jsSnippet: "",
        insertion: .appendToBody
    )
    
    // MARK: - Lesson 4: Links & Navigation
    static let lesson4Template = PortfolioTemplate(
        htmlSnippet: """
        
        <section id="links">
            <h2>Useful Links</h2>
            <p>Check out these resources:</p>
            <ul>
                <li><a href="https://developer.mozilla.org" target="_blank">MDN Web Docs</a></li>
                <li><a href="https://www.w3schools.com" target="_blank">W3Schools</a></li>
            </ul>
        </section>
        """,
        cssSnippet: """
        
        /* Links section from Lesson 4 */
        #links {
            padding: 60px 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        
        #links h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #333;
        }
        
        #links a {
            color: #58a6ff;
            text-decoration: none;
            font-weight: 500;
        }
        
        #links a:hover {
            text-decoration: underline;
        }
        """,
        jsSnippet: "",
        insertion: .appendToBody
    )
    
    // MARK: - Lesson 5: Images & Media
    static let lesson5Template = PortfolioTemplate(
        htmlSnippet: """
        
        <section id="gallery">
            <h2>Gallery</h2>
            <p>Placeholder for images from Lesson 5.</p>
        </section>
        """,
        cssSnippet: """
        
        /* Gallery from Lesson 5 */
        #gallery {
            padding: 60px 20px;
            background: #f8f9fa;
            text-align: center;
        }
        
        #gallery h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #333;
        }
        """,
        jsSnippet: "",
        insertion: .appendToBody
    )
    
    // ═══════════════════════════════════════════
    // PHASE 2 – CSS STYLING (Lessons 6-8)
    // ═══════════════════════════════════════════
    
    // MARK: - Lesson 6: Colors & Backgrounds
    static let lesson6Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Enhanced colors from Lesson 6 */
        header {
            background: linear-gradient(135deg, #0d1117, #161b22);
        }
        
        section:nth-child(even) {
            background: #f0f4f8;
        }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // MARK: - Lesson 7: Fonts & Typography
    static let lesson7Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Typography from Lesson 7 */
        h1, h2, h3 {
            font-family: 'Segoe UI', Arial, sans-serif;
            letter-spacing: -0.5px;
        }
        
        p, li {
            line-height: 1.8;
        }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // MARK: - Lesson 8: Box Model & Spacing
    static let lesson8Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Box model polish from Lesson 8 */
        section {
            padding: 80px 20px;
        }
        
        * {
            box-sizing: border-box;
        }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // ═══════════════════════════════════════════
    // PHASE 3 – FLEXBOX, NAV & RESPONSIVE (Lessons 9-14)
    // ═══════════════════════════════════════════
    
    // MARK: - Lesson 9: Flexbox Layout
    static let lesson9Template = PortfolioTemplate(
        htmlSnippet: """
        
        <section id="projects">
            <h2>My Projects</h2>
            <div class="flex-container">
                <div class="project-card">
                    <h3>Project One</h3>
                    <p>A brief description of your first project.</p>
                </div>
                <div class="project-card">
                    <h3>Project Two</h3>
                    <p>A brief description of your second project.</p>
                </div>
                <div class="project-card">
                    <h3>Project Three</h3>
                    <p>A brief description of your third project.</p>
                </div>
            </div>
        </section>
        """,
        cssSnippet: """
        
        /* Flexbox layout from Lesson 9 */
        .flex-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .project-card {
            flex: 1;
            min-width: 250px;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }
        
        .project-card:hover {
            transform: translateY(-5px);
        }
        
        .project-card h3 {
            color: #58a6ff;
            margin-bottom: 10px;
        }
        """,
        jsSnippet: "",
        insertion: .appendToBody
    )
    
    // MARK: - Lesson 10: Building a Navigation Bar
    static let lesson10Template = PortfolioTemplate(
        htmlSnippet: """
        <nav id="navigation">
            <span class="logo">MyPortfolio</span>
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#skills">Skills</a></li>
                <li><a href="#projects">Projects</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
        """,
        cssSnippet: """
        
        /* Navigation from Lesson 10 */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background: #0d1117;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .logo {
            color: #58a6ff;
            font-weight: bold;
            font-size: 1.3rem;
        }
        
        nav ul {
            display: flex;
            list-style: none;
            gap: 5px;
            margin: 0;
            padding: 0;
        }
        
        nav a {
            color: #c9d1d9;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 6px;
            transition: background 0.3s;
        }
        
        nav a:hover {
            background: #21262d;
            color: #58a6ff;
        }
        """,
        jsSnippet: "",
        insertion: .appendToBody
    )
    
    // MARK: - Lesson 11: Intro to Responsive Design (media query concept)
    static let lesson11Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Responsive basics from Lesson 11 */
        @media (max-width: 768px) {
            header h1 { font-size: 1.8rem; }
            section { padding: 40px 15px; }
        }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // MARK: - Lesson 12: Mobile-First Design
    static let lesson12Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Mobile-first from Lesson 12 */
        @media (max-width: 600px) {
            .flex-container {
                flex-direction: column;
                align-items: center;
            }
            .project-card { min-width: 100%; }
        }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // MARK: - Lesson 13: Responsive Images & Units
    static let lesson13Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Responsive units from Lesson 13 */
        img { max-width: 100%; height: auto; }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // MARK: - Lesson 14: Responsive Nav Bar
    static let lesson14Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Responsive nav from Lesson 14 */
        @media (max-width: 768px) {
            nav {
                flex-direction: column;
                padding: 10px;
            }
            nav ul {
                flex-direction: column;
                width: 100%;
                text-align: center;
            }
            nav a { padding: 12px; display: block; }
        }
        """,
        jsSnippet: "",
        insertion: .appendToCSS
    )
    
    // ═══════════════════════════════════════════
    // PHASE 4 – JAVASCRIPT INTERACTIVITY (Lessons 15-18)
    // ═══════════════════════════════════════════
    
    // MARK: - Lesson 15: Intro to JavaScript
    static let lesson15Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: "",
        jsSnippet: """
        
        // Welcome alert from Lesson 15
        // function showWelcome() {
        //     alert("Welcome to my portfolio!");
        // }
        """,
        insertion: .appendToJS
    )
    
    // MARK: - Lesson 16: DOM Manipulation
    static let lesson16Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: "",
        jsSnippet: """
        
        // DOM manipulation from Lesson 16
        // Example: dynamically update content
        """,
        insertion: .appendToJS
    )
    
    // MARK: - Lesson 17: Form Validation
    static let lesson17Template = PortfolioTemplate(
        htmlSnippet: """
        
        <section id="contact">
            <h2>Contact Me</h2>
            <form onsubmit="return validateContact()">
                <input id="contactName" placeholder="Your name" type="text">
                <input id="contactEmail" placeholder="Your email" type="email">
                <textarea id="contactMessage" placeholder="Your message..."></textarea>
                <button type="submit">Send</button>
            </form>
            <p id="contactFeedback"></p>
        </section>
        """,
        cssSnippet: """
        
        /* Contact form from Lesson 17 */
        #contact {
            padding: 80px 20px;
            background: #f8f9fa;
        }
        
        #contact h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 30px;
            color: #333;
        }
        
        #contact form {
            max-width: 500px;
            margin: 0 auto;
        }
        
        #contact input, #contact textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        
        #contact textarea { min-height: 100px; }
        
        #contact button {
            width: 100%;
            padding: 14px;
            background: #238636;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
        }
        
        #contact button:hover { background: #2ea043; }
        #contactFeedback { text-align: center; margin-top: 15px; }
        """,
        jsSnippet: """
        
        // Contact form validation from Lesson 17
        function validateContact() {
            let name = document.getElementById("contactName").value;
            let email = document.getElementById("contactEmail").value;
            let message = document.getElementById("contactMessage").value;
            let feedback = document.getElementById("contactFeedback");
            
            if (name === "" || email === "" || message === "") {
                feedback.innerText = "Please fill in all fields!";
                feedback.style.color = "#ff6b6b";
                return false;
            }
            feedback.innerText = "Message sent! Thank you!";
            feedback.style.color = "#4ecdc4";
            return false;
        }
        """,
        insertion: .appendToBody
    )
    
    // MARK: - Lesson 18: Dark Mode Toggle
    static let lesson18Template = PortfolioTemplate(
        htmlSnippet: "",
        cssSnippet: """
        
        /* Dark mode from Lesson 18 */
        body { transition: background 0.3s, color 0.3s; }
        body.dark-mode { background: #0d1117; color: #c9d1d9; }
        body.dark-mode section:nth-child(even) { background: #161b22; }
        body.dark-mode .project-card { background: #21262d; }
        body.dark-mode #contact { background: #161b22; }
        body.dark-mode #contact input,
        body.dark-mode #contact textarea {
            background: #0d1117;
            border-color: #30363d;
            color: #c9d1d9;
        }
        """,
        jsSnippet: """
        
        // Dark mode toggle from Lesson 18
        function toggleTheme() {
            document.body.classList.toggle("dark-mode");
            let btn = document.getElementById("themeBtn");
            if (btn) {
                btn.innerText = document.body.classList.contains("dark-mode")
                    ? "☀️ Light Mode" : "🌙 Dark Mode";
            }
        }
        """,
        insertion: .appendToCSS
    )
    
    // Lessons 19-21 are theory-only and do not add portfolio content.
}
