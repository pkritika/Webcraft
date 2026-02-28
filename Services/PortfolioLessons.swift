//
//  PortfolioLessons.swift
//  WebCraft
//
//  Complete 21-lesson curriculum: HTML → CSS → Responsive → JS → Deploy
//

import Foundation

struct PortfolioLessons {
    static let allLessons: [Lesson] = [
        
        // ════════════════════════════════════════════════════════
        // MODULE 1: The Web & HTML Basics  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: How the Internet Works ──────────────
        Lesson(
            id: 1,
            title: "How the Internet Works",
            description: "Discover the difference between the Internet and the Web, and trace how a page reaches your screen",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: nil,
            moduleTitle: "Module 1: The Web & HTML Basics",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Internet vs. World Wide Web",
                    content: """
                    The **Internet** = the global network of connected computers (think of it as the 'highway'). \n
                    
                    The **World Wide Web** = one application that runs on the Internet like cars on that highway.

                    Email and video streaming also use the Internet but are NOT the Web.

                    How a web page reaches you in under 1 second:
                    1. You type a URL into your browser
                    2. Your browser sends a request over the Internet to find the right server
                    3. The server locates the correct file on its hard drive
                    4. The server sends a copy of the HTML source code back to you
                    5. Your browser reads the HTML and draws the formatted page on screen
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .theory,
                    title: "Client vs. Server",
                    content: """
                    Two roles — every web interaction uses both:

                    **Client** Your computer or phone. It makes requests. It's the one asking for things.
                    **Server** The computer storing the website. It receives requests and sends files back.

                    Example : What actually travels across the Internet:
                    ```
                    CLIENT sends: GET / HTTP/1.1 | Host: www.google.com

                    SERVER replies: HTTP/1.1 200 OK   ← '200' means Found it!
                    <!doctype html>   ← the HTML code follows…
                    ```

                    📌 Common status codes: 
                    **200** = OK  
                    **404** = Not Found
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: Key Web Terminology ─────────────────
        Lesson(
            id: 2,
            title: "Key Web Terminology",
            description: "Master the 8 essential terms every web developer must know",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 1,
            moduleTitle: "Module 1: The Web & HTML Basics",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "8 Terms Every Developer Knows",
                    content: """
                    HyperText Markup Language(HTML) is the languag all web pages are writtem and the language every developer needs to speak. Here are the most-known terms: 

                    **URL** Uniform Resource Locator is a web address (e.g. https://example.com/page.html)
                    **HTTP / HTTPS** The rules computers follow to send web pages. HTTPS = secure/encrypted
                    **Protocol** An agreed set of rules allowing two computers to talk to each other
                    **Web Browser** Software that reads HTML and displays it visually (Chrome, Firefox, Safari)
                    **Web Server** Computer that stores websites and sends them to browsers on request
                    **Source Code** The raw HTML/CSS text that makes a page — before the browser processes it
                    **FTP** File Transfer Protocol is how you upload your files to a web server
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Reading a URL",
                    
                    
                    content: """
                    💡 Every URL has four parts — learn to read them:
                        Protocol→ https (rules for communication)
                        Domain→ www.stanford.edu (the server's address)
                        Path→ /group/cs21/ (folder on the server)
                        Filename→ index.html (the specific file)
                    """,
                    
                    codeExample: """
                    https://www.stanford.edu/group/cs21/index.html
                    │_____│ |______________││________│ │_________│
                    Protocol     Domain       Path      Filename
                    
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: Introduction to HTML ────────────────
        Lesson(
            id: 3,
            title: "Introduction to HTML",
            description: "Write your first HTML: tags, attributes, and the structure of every web page",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 2,
            moduleTitle: "Module 1: The Web & HTML Basics",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Tags & Attributes",
                    content: """
                    An HTML **tag** is a keyword inside angle brackets `< >` and it comes in pair i.e an opening tag and a closing tag with a ( / ):
                    ```
                    <tagname>  content goes here  </tagname>
                    ```

                    Tags can also carry **attributes** that add extra information:
                    ```
                    <p style="text-align: center;">  Centered text  </p>
                    ```
                    💡 Here style is the attribute and text-align is the value.

                    🏗️ Required structure of EVERY HTML page:
                    ```
                    <!doctype html>           ← Declares HTML5. Always line 1.
                    <html>                    ← Root wrapper for everything
                      <head>                  ← Invisible info (title, CSS links)
                        <title>Page Title</title>
                      </head>
                      <body>                  ← Everything the visitor SEES
                        ...content here...
                      </body>
                    </html>
                    ```
                    💡 Pro tip: Indent nested tags with spaces. It doesn't change how the page looks but it makes your code dramatically easier to
                    read and debug.
                    
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .theory,
                    title: "Essential Tags",
                    content: """
                    📝 These are the tags you'll use on almost every page:

                    **<h1> … <h6>** Headings: h1 biggest, h6 smallest
                    **<p> … </p>** Paragraph (adds space above & below)
                    **<strong> … </strong>**  Bold text
                    **<em> … </em>** Italic text 
                    **<br />** Line break (self-closing, no ending tag needed)
                    **<hr />** Horizontal dividing line (self-closing)
                    **<header>** Page header section (site name, logo, nav)
                    **<nav>** Navigation menu links
                    **<main>** The main content area of the page
                    **<footer>** Bottom of page (copyright, contact)
                    **<section>** A thematic section within the page
                    **<article>** Self-contained content (e.g. a blog post)
                    **<aside>** Sidebar, ads, supplementary content
                    **<div>** Generic container — no special meaning
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "A Complete Web Page",
                    content: "Here's a full working page using the structure and tags you just learned:",
                    codeExample: """
                    <!doctype html>
                    <html>
                      <head><title>All About Dogs</title></head>
                      <body>
                        <header>
                          <h1>Welcome to My Dog Website!</h1>
                        </header>
                        <main>
                          <h2>Why Dogs Are Amazing</h2>
                          <p>Dogs have been companions for over <strong>15,000 years</strong>.</p>
                          <h3>My Favorite Breeds</h3>
                          <p>Golden Retrievers are loyal.<br />Border Collies are brilliant.</p>
                        </main>
                        <footer><p>Created by a WebCraft student 🐾</p></footer>
                      </body>
                    </html>
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: Planning Your Website ───────────────
        Lesson(
            id: 4,
            title: "Planning Your Website",
            description: "Learn the 4 professional steps developers take before writing a single line of code",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 3,
            moduleTitle: "Module 1: The Web & HTML Basics",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Plan Before You Code",
                    content: """
                    Never jump straight into coding. Professional developers always **plan first** always take a few minutes of planning and
                    prevents hours of frustration.

                    Remember these 4 steps before writing a single line of code:
                    1. **AUDIENCE** — Who will visit? (friends, customers, fans?) — this shapes every design decision.
                    2. **GOALS** — What should the site achieve? (share info, sell products, build a community?)
                    3. **SITE MAP** — Sketch all your pages and how they connect before writing any code.
                    4. **FILE STRUCTURE** — Organize files into logical folders. Always name your home page index.html.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                
            ]
        ),

        // ── SUB-LESSON 5: Module 1 Quiz ───────────────────────
        Lesson(
            id: 5,
            title: "Module 1 Quiz",
            description: "10 questions covering everything in Module 1 — earn your 500 XP!",
            difficulty: .beginner,
            xpReward: 500,
            prerequisiteId: 4,
            moduleTitle: "Module 1: The Web & HTML Basics",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the difference between the Internet and the World Wide Web?",
                        options: [
                            "They are exactly the same thing.",
                            "The Internet is the global network; the Web is one application that runs on it.",
                            "The Web is the physical cables; the Internet is the websites.",
                            "The Internet only works with HTTP; the Web uses any protocol."
                        ],
                        correctAnswerIndex: 1,
                        explanation: "The Internet is the infrastructure ('highway'). The Web is one app ('cars') that uses it. Email and streaming also use the Internet but are not the Web."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the correct order of events when you visit a website?",
                        options: [
                            "Browser displays → Server finds file → Request sent",
                            "Server sends HTML → Browser requests → Browser displays",
                            "Browser requests → Server finds file → Server sends HTML → Browser displays",
                            "Server requests → Browser finds HTML → Page displays"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "The client (browser) always initiates. The server locates the file, sends back HTML, and the browser renders the page."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does HTML stand for?",
                        options: [
                            "Hyper Transfer Markup Lingo",
                            "High Text Making Language",
                            "HyperText Markup Language",
                            "Horizontal Text and More Language"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "HyperText = text that links to other text. Markup = tags used to annotate and structure content."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which tag contains everything the visitor actually SEES on a web page?",
                        options: ["<head>", "<html>", "<title>", "<body>"],
                        correctAnswerIndex: 3,
                        explanation: "<body> holds all visible content. <head> has invisible info (title, CSS). <title> only sets the browser tab text."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which HTML correctly makes text appear BOLD?",
                        options: [
                            "<bold>WebCraft is awesome</bold>",
                            "<b>WebCraft is awesome</b>",
                            "<strong>WebCraft is awesome</strong>",
                            "<em>WebCraft is awesome</em>"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "<strong> is the modern HTML5 way. <b> is outdated (no semantic meaning). <em> makes text italic."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the main purpose of a site map when planning a website?",
                        options: [
                            "To write HTML code faster",
                            "To choose a web server",
                            "To map out all pages and their connections before coding",
                            "To design colors and fonts"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "A site map is a planning blueprint — all pages and how they link, like a building's floor plan. Created before any coding begins."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does <!doctype html> do?",
                        options: [
                            "Downloads HTML onto your computer",
                            "Tells the browser this document uses HTML5",
                            "Creates the visible page title",
                            "Links the page to a CSS stylesheet"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "DOCTYPE is an instruction, not a tag. It tells the browser which HTML version to expect. <!doctype html> = HTML5."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which tag creates a horizontal dividing line across the page?",
                        options: ["<line />", "<divide />", "<br />", "<hr />"],
                        correctAnswerIndex: 3,
                        explanation: "<hr /> = Horizontal Rule (visible line). <br /> = line break only (no visible line). Both are self-closing."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 9",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Why should your home page always be named 'index.html'?",
                        options: [
                            "Required by HTML5 standards",
                            "Web servers automatically load index.html when a folder URL is visited",
                            "It makes the page load faster",
                            "Other filenames aren't allowed by browsers"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Web servers are configured to serve index.html automatically when someone visits a folder URL like www.example.com/. Any other name = error."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 10",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "A browser receives HTML source code from a server. What does it do next?",
                        options: [
                            "Sends it to a second server for processing",
                            "Stores it permanently on the hard drive",
                            "Reads the tags and renders the formatted page on screen",
                            "Deletes all tags and shows only plain text"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "The browser is an HTML interpreter — it reads every tag and translates them into the visual page you see, including headings, images, paragraphs, and colors."
                    )
                ),
            ]
        ),

        // ════════════════════════════════════════════════════════
        // MODULE 2: Links, Colors & Fonts  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: Hyperlinks ──────────────────────────
        Lesson(
            id: 6,
            title: "Hyperlinks",
            description: "Create links between pages and to external sites using absolute and relative URLs",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 5,
            moduleTitle: "Module 2: Links, Colors & Fonts",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Creating Hyperlinks",
                    content: """
                    Links are made with the <a> (anchor) tag, using an attribute called **href** (Hypertext Reference) to specify the destination URL.

                    ```
                    <a href="URL">Link Text</a>
                    ```

                    💡 Breaking it down:
                    • <a href="..."> — opening tag with destination
                    • "URL" — the web address to link to
                    • Link Text — the clickable text users see
                    • </a> — closing tag

                    🔑 Two Types of URLS: 
                    
                    Absoulute URL: It is full internet address with protocol and domain. It is used for external links or for other domains. It always starts with http:// or https:// 
                    
                    Relative URL: It is a path relative to your current page. It is usd for your own site's page or
                    file in the same project. It does not require any protocol just filename or path.
                    
                    
                    💡 **Rule of thumb**: 
                    If it's YOUR page → use relative. 
                    If it's someone else's site → use absolute.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .theory,
                    title: "Link Rules",
                    content: """

                    When using relative links, you need to know how to navigate your folder structure:
                    1. File in the same folder: href= "page.html"         
                    2. Go into the "work" subfolder: href= "work/resume.html" 
                    3. Go up one folder level (../ means "parent folder"): href= "../index.html"  
                    4. Go up two folder levelshref: href=" ../../home.html" 

                    **3 Rules for Links:**
                    1. Case counts — About.html ≠ about.html on most servers
                    2. The URL must be exact — one typo breaks the link entirely
                    3. Always put visible text between <a> and </a> — empty tags create invisible links
                    """,
                    codeExample: """
                    <!-- ABSOLUTE LINKS- points to external Websites-->
                    <a href="https://www.linked.com">My Linked Profile</a>
                        
                    <!-- Relative links- points to pages on your Own site-->
                    <a href="index.html">Home</a> 
                    """,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Nav Bar Example",
                    content: "Here's how to build a real navigation menu using anchor tags just like you see on every professional website:",
                    codeExample: """
                    <!-- Navigation bar using structural tag -->
                    <nav>
                    <a href="index.html">Home</a>
                    <a href="aboutme.html">About Me</a>
                    <a href="project.html">Project</a>
                    <a href="Contact.html">Contact</a>
                    </nav>
                    """
                    ,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: Special Characters ─────────────────
        Lesson(
            id: 7,
            title: "Special Characters",
            description: "Display symbols, accents, and angle brackets safely using HTML entities",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 6,
            moduleTitle: "Module 2: Links, Colors & Fonts",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "HTML Entities",
                    content: """
                    HTML files are plain text. To display characters not on a standard keyboard — or to show angle brackets without confusing the browser — use HTML character entities.

                    Every entity starts with **&** and ends with **;**

                    **&copy;** — © Copyright
                    **&reg;** — ® Registered trademark
                    **&trade;** — ™ Trademark
                    **&amp;** — & Ampersand (the & itself!)
                    **&lt;** — < Less-than / open angle bracket
                    **&gt;** — > Greater-than / close angle bracket
                    **&nbsp;** — (non-breaking space — prevents line wrap)
                    **&ntilde;** — ñ n with tilde
                    **&eacute;** — é e with accent
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Why &lt; and &gt; Are Critical",
                    content: "💡 Failing to escape angle brackets breaks your page:",
                    codeExample: """
                    WRONG — browser thinks < starts a new tag:
                    <p>When x < 10, loop runs.</p>

                    CORRECT — use the entity:
                    <p>When x &lt; 10, loop runs.</p>

                    Copyright line example:
                    <p>WebCraft &copy; 2024 All Rights Reserved.</p>
                    → Displays: WebCraft © 2024 All Rights Reserved.
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: Web Colors ──────────────────────────
        Lesson(
            id: 8,
            title: "Web Colors",
            description: "Master hex color codes and understand the #RRGGBB system",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 7,
            moduleTitle: "Module 2: Links, Colors & Fonts",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Hex Color Codes",
                    content: """
                    Web colors use hexadecimal codes in the format **#RRGGBB** — two characters each for Red, Green, and Blue. Each pair goes from 00 (none) to FF (maximum).

                    Hex digit order: 0 1 2 3 4 5 6 7 8 9 A B C D E F
                    • FF = 255 = maximum
                    • 00 = 0 = none

                    **#FF0000** — max Red, no Green, no Blue = Pure RED
                    **#00FF00** — no Red, max Green, no Blue = Pure GREEN
                    **#0000FF** — no Red, no Green, max Blue = Pure BLUE
                    **#FFFFFF** — max all three = WHITE
                    **#000000** — zero all three = BLACK
                    **#FFA500** — lots Red, some Green, no Blue = ORANGE
                    **#808080** — medium all three = GRAY
                    **#FFFF00** — max Red + Green, no Blue = YELLOW

                    📌 Always aim for HIGH CONTRAST — light text on dark background or dark text on light background. Low contrast = hard to read on any device.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Old vs Modern Color Approach",
                    content: "💡 The old HTML bgcolor approach is deprecated — always use CSS instead:",
                    codeExample: """
                    OLD way (deprecated — avoid):
                    <body bgcolor="red" text="yellow" link="green">

                    bgcolor = background color
                    text    = text color
                    link    = link color

                    MODERN way (CSS):
                    body {
                      background-color: #0d1117;
                      color: #c9d1d9;
                    }
                    a { color: #58a6ff; }
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: Working with Fonts ─────────────────
        Lesson(
            id: 9,
            title: "Working with Fonts",
            description: "Understand font categories, fallback stacks, and why CSS is the right way to set fonts",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 8,
            moduleTitle: "Module 2: Links, Colors & Fonts",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Font Categories & Fallbacks",
                    content: """
                    Key problem: fonts only display if installed on the visitor's device. Always provide fallback fonts ending with a generic family.

                    **Serif** — Times New Roman, Georgia — best for print / traditional look
                    **Sans-Serif** — Arial, Verdana, Helvetica — best for screen reading (most websites)
                    **Monospace** — Courier New, Consolas — best for code, typewriter effect

                    Font stack — browser tries each font left to right:
                    ```
                    font-family: Palatino, "Book Antiqua", Georgia, serif;
                    ```
                    If Palatino isn't installed → tries Book Antiqua → Georgia → fallback serif.

                    📌 Always end your font stack with a generic family: serif, sans-serif, or monospace.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "The <font> Tag vs CSS",
                    content: "💡 The <font> tag is deprecated — only acceptable in email newsletters. Use CSS for real websites:",
                    codeExample: """
                    OLD way — <font> tag (email newsletters only):
                    <font face="Arial" color="#FF0000" size="4">Red text</font>

                    face="FontName"   ← font to use
                    color="#RRGGBB"   ← text color
                    size="1 to 7"     ← 1=tiny, 7=huge, 3=default

                    MODERN way — CSS (use this for all real websites):
                    body {
                      font-family: Arial, Helvetica, sans-serif;
                      color: #333333;
                      font-size: 16px;
                    }

                    h1 { font-family: Georgia, serif; font-size: 2rem; }
                    code { font-family: "Courier New", monospace; }
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 5: Module 2 Quiz ───────────────────────
        Lesson(
            id: 10,
            title: "Module 2 Quiz",
            description: "10 questions on hyperlinks, entities, colors and fonts — earn your 600 XP!",
            difficulty: .beginner,
            xpReward: 600,
            prerequisiteId: 9,
            moduleTitle: "Module 2: Links, Colors & Fonts",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does the href attribute in an anchor tag specify?",
                        options: [
                            "The color the link text appears",
                            "The destination URL — where the link takes the user",
                            "The size of the clickable text",
                            "The name of the file the link is on"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "HREF = Hypertext Reference. It sets where the browser navigates when the link is clicked. Without it, the anchor has no destination."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the difference between href=\"https://www.google.com\" and href=\"about.html\"?",
                        options: [
                            "First opens in new tab; second in same tab",
                            "First is absolute (full external address); second is relative (your own site)",
                            "First is more secure because it uses HTTPS",
                            "No difference — both work the same way"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Absolute URL = full address including protocol and domain (for external sites). Relative URL = path only, relative to current page (for your own site pages)."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Why must you write &lt; instead of < when displaying a less-than symbol?",
                        options: [
                            "< is not on all keyboards",
                            "Browsers filter < for security",
                            "Browser sees bare < as the start of an HTML tag and gets confused",
                            "&lt; displays larger"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "HTML parsers treat any < as the beginning of a tag. The entity &lt; tells the browser to display a literal symbol instead."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does the hex color #FF0000 represent?",
                        options: ["Black", "White", "Pure Blue", "Pure Red"],
                        correctAnswerIndex: 3,
                        explanation: "#FF0000: RR=FF (max red), GG=00 (no green), BB=00 (no blue). Maximum red + nothing else = pure red."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "A file is saved as 'contact.html' but the link says href=\"Contact.html\". What happens?",
                        options: [
                            "Works fine — HTML is case-insensitive",
                            "Link text changes color to signal error",
                            "Link is broken on most web servers (case-sensitive)",
                            "Browser auto-searches for the correct filename"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Most servers (Linux-based) treat Contact.html and contact.html as different files. Case mismatch = broken link — one of the most common beginner mistakes."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does #FFFFFF represent?",
                        options: ["Black", "White", "Pure Red", "Transparent"],
                        correctAnswerIndex: 1,
                        explanation: "White = maximum red + maximum green + maximum blue. #FF=max for each channel. #000000 = Black (zero of everything)."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the HTML entity for the copyright symbol ©?",
                        options: ["&copyright;", "&copy;", "&#copy;", "&c;"],
                        correctAnswerIndex: 1,
                        explanation: "Pattern: & + code name + ;  The entity is &copy; — simple, named, and works in all browsers."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Why is the <font> tag considered deprecated in modern web development?",
                        options: [
                            "It was removed in HTML5",
                            "Too slow — increases page load time",
                            "W3C recommends CSS instead — <font> mixes content with presentation",
                            "Only works in Internet Explorer"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Deprecated = discouraged but still works. Modern best practice: HTML = content structure, CSS = visual presentation. CSS styles a whole site from one file."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 9",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does href=\"../index.html\" mean?",
                        options: [
                            "Link to index.html in a folder named '..'",
                            "Link to index.html in the current folder",
                            "Go up one folder level, then link to index.html",
                            "Link to a page named ..index.html"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "../ means 'go up to the parent folder.' So ../index.html = go up one level, then find index.html there."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 10",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "You want ALL text on your page to use Arial font. What is the best modern approach?",
                        options: [
                            "Add <font face=\"Arial\"> to every paragraph",
                            "Add face=\"Arial\" to the <body> tag",
                            "Use CSS: body { font-family: Arial, Helvetica, sans-serif; }",
                            "There is no way to set a default font"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "CSS applied to the body selector cascades to all elements on the page. One rule does the work of a hundred <font> tags."
                    )
                ),
            ]
        ),

        // ════════════════════════════════════════════════════════
        // MODULE 3: Introduction to CSS  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: What is CSS? ──────────────────────────
        Lesson(
            id: 11,
            title: "What is CSS?",
            description: "Discover what CSS does, the 3 ways to add it, and why external stylesheets are the pro choice",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 10,
            moduleTitle: "Module 3: Introduction to CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "CSS — The Stylist of the Web",
                    content: """
                    **CSS** = Cascading Style Sheets.
                    HTML builds the structure. CSS controls how it looks — colors, fonts, spacing, layout.

                    Without CSS every website looks the same: black Times New Roman text on a white page.

                    🎨 3 ways to add CSS (from least to most professional):

                    **1. Inline** — `style=` attribute directly on one tag:
                    ```
                    <h1 style="color: green;">Green Heading</h1>
                    ```
                    ❌ Hard to maintain — have to change every tag individually.

                    **2. Internal** — `<style>` block inside `<head>`:
                    ```
                    <head>
                      <style>
                        h1 { color: green; }
                      </style>
                    </head>
                    ```
                    ⚠️ Only affects that one page.

                    **3. External** — a separate `.css` file linked from every page:
                    ```
                    <head>
                      <link rel="stylesheet" href="style.css" />
                    </head>
                    ```
                    ✅ Change one file → every page on your site updates instantly.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .theory,
                    title: "The Cascade Rule",
                    content: """
                    CSS = **Cascading** Style Sheets. When two rules conflict, the one that appears **last** wins.

                    ```
                    h2 { color: green; }
                    h2 { color: purple; }  ← this one wins
                    ```

                    📌 Priority (lowest → highest):
                    1. External stylesheet
                    2. Internal `<style>` block
                    3. Inline `style=` attribute

                    💡 Inline styles always beat internal and external — use with caution.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: CSS Selectors ──────────────────────
        Lesson(
            id: 12,
            title: "CSS Selectors",
            description: "Master the selector + property + value rule syntax and target exactly what you want",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 11,
            moduleTitle: "Module 3: Introduction to CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Rule Syntax & Selectors",
                    content: """
                    Every CSS rule has three parts:
                    ```
                    selector { property: value; }
                    ```

                    **selector** — what to style (a tag, class, or ID)
                    **property** — what to change (color, font-size, margin…)
                    **value** — what to set it to (#ff0000, 16px, bold…)

                    One rule can set multiple properties:
                    ```
                    h1 {
                      color: #1E1B4B;
                      font-size: 2em;
                      text-align: center;
                    }
                    ```

                    🔑 Common selector types:
                    **h2 { }** — targets ALL `<h2>` tags on the page
                    **.highlight { }** — targets any element with `class="highlight"`
                    **#intro { }** — targets the ONE element with `id="intro"`
                    **p.shade { }** — targets ONLY `<p>` tags that also have `class="shade"`
                    **h1#intro { }** — targets ONLY an `<h1>` that has `id="intro"`
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "CSS in Action",
                    content: "💡 A complete external stylesheet with many selectors:",
                    codeExample: """
                    /* style.css */
                    body {
                      background-color: #f5f5f5;
                      font-family: Arial, Helvetica, sans-serif;
                      color: #333333;
                    }

                    h1 { color: #1E1B4B; font-size: 2em; }
                    h2 { color: #3730A3; font-size: 1.4em; }

                    p { font-size: 16px; line-height: 1.6; }

                    .highlight { background-color: #cccccc; }
                    p.shade    { background-color: red; }

                    #intro     { font-size: 2em; }
                    h1#intro   { color: green; }
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: Classes & IDs ──────────────────────
        Lesson(
            id: 13,
            title: "Classes & IDs",
            description: "Apply styles to specific elements using .class and #id selectors",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 12,
            moduleTitle: "Module 3: Introduction to CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Class vs ID",
                    content: """
                    Classes and IDs let you style specific elements — not just all `<h2>` tags globally, but individual chosen ones.

                    | | **Class** | **ID** |
                    |---|---|---|
                    | CSS selector | `.name` | `#name` |
                    | HTML attribute | `class="name"` | `id="name"` |
                    | Reusable? | ✅ Yes — unlimited elements | ❌ No — ONE per page |
                    | Use when | Styling a type of thing | Styling one unique element |

                    📌 Rule of thumb:
                    • Use **class** for repeating patterns (buttons, cards, highlighted text)
                    • Use **ID** for unique landmarks (page header, main nav, footer)
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Class & ID Example",
                    content: "💡 Combining classes and IDs for precise control:",
                    codeExample: """
                    /* CSS */
                    .highlight  { background-color: #cccccc; }
                    p.shade     { background: red; }
                    #intro      { font-size: 2em; }
                    h1#intro    { color: green; }

                    <!-- HTML -->
                    <p>This paragraph is NOT highlighted.</p>
                    <p class="highlight">This one IS highlighted.</p>
                    <p class="shade">Only <p> with shade → red bg.</p>
                    <h1 id="intro">This h1 is the intro.</h1>
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: Span, Div & Font Styling ───────────
        Lesson(
            id: 14,
            title: "Span, Div & Font Styling",
            description: "Group content with <span> and <div>, and use CSS font properties like a pro",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 13,
            moduleTitle: "Module 3: Introduction to CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Span vs Div",
                    content: """
                    Both `<span>` and `<div>` are invisible containers — they only become useful when styled with CSS.

                    **<span>** — INLINE container
                    • Wraps text without starting a new line
                    • Use to style a word or phrase within a sentence
                    ```
                    <p>The sky is <span class="sky">bright blue</span> today.</p>
                    ```

                    **<div>** — BLOCK container
                    • Starts on a new line, takes full width
                    • Use to group and style whole sections
                    ```
                    <div id="header">
                      <h1>Site Title</h1>
                      <nav>...</nav>
                    </div>
                    ```

                    🎮 **Pro Tip:** `.neatstuff { font-family: 'Comic Sans MS'; }`
                    then `<span class="neatstuff">This text is Comic Sans</span>`
                    — CSS class + span gives you pinpoint control over any inline text without affecting anything else.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .theory,
                    title: "CSS Font & Text Properties",
                    content: """
                    The most-used CSS text properties — every website needs these:

                    **font-family** — which font to use
                    ```
                    body { font-family: Verdana, Arial, Helvetica, sans-serif; }
                    ```
                    Always end with a generic family as fallback.

                    **font-size** — size of text
                    • `16px` — exact pixel size
                    • `2em` — 2× the current/parent font size

                    **font-weight: bold** — makes text bold
                    **font-style: italic** — makes text italic
                    **text-align: center** — left | center | right | justify
                    **color: #1E1B4B** — text color (hex)
                    **background-color: #fff** — background color

                    📌 Print vs Screen tip:
                    • Screen → use **sans-serif** (Verdana, Arial, Helvetica) — cleaner pixels
                    • Print → use **serif** (Times, Georgia) — serifs aid reading in ink
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Span, Div & Classes Together",
                    content: "💡 Here's how span, div, class, and ID all work together:",
                    codeExample: """
                    <head>
                      <style>
                        #topic1   { background: black; color: white; }
                        #topic2   { background: #f00;  color: yellow; margin-top: 40px; }
                        .important {
                          background: #0F0;
                          border: thin dotted #999;
                          padding: 5px;
                          color: black;
                        }
                      </style>
                    </head>
                    <body>
                      <div id="topic1">This is topic number 1</div>
                      <div id="topic2">
                        This is the
                        <span class="important">most important</span> topic
                      </div>
                    </body>

                    Result:
                    topic1 = black bg, white text
                    topic2 = red bg, yellow text
                    "most important" = green bg, dotted border
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 5: Module 3 Quiz ──────────────────────
        Lesson(
            id: 15,
            title: "Module 3 Quiz",
            description: "10 questions on CSS rules, selectors, classes, IDs and fonts — earn your 700 XP!",
            difficulty: .beginner,
            xpReward: 700,
            prerequisiteId: 14,
            moduleTitle: "Module 3: Introduction to CSS",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "In CSS, what are the three parts of a rule?",
                        options: [
                            "Tag, attribute, and value",
                            "Selector, property, and value",
                            "Class, ID, and element",
                            "Font, color, and size"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Syntax: selector { property: value; } The selector targets what to style, the property is what to change, and the value is what to change it to."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "You change a site-wide CSS rule from color: blue to color: green. What happens?",
                        options: [
                            "Only the first page of the site updates",
                            "Every page that links to that CSS file updates automatically",
                            "You must manually update every HTML file",
                            "Only h1 tags update — other tags stay blue"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "This is CSS's superpower. One external .css file controls all linked pages. Change one rule = instant site-wide update."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which method of adding CSS is best for a professional website?",
                        options: [
                            "Inline style= attributes on every tag",
                            "A <style> block inside each page's <head>",
                            "An external .css file linked with <link> in every page's <head>",
                            "Using the deprecated <font> tag"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "External CSS = change once, update everywhere. Internal CSS = only that page. Inline = only that tag. External is always the professional choice for real sites."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the difference between a CSS class and a CSS ID?",
                        options: [
                            "Classes use # and IDs use . in CSS",
                            "Classes can be used on multiple elements; IDs must be unique (one per page)",
                            "IDs can be reused; classes cannot",
                            "There is no difference — they work identically"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Class (.name) = reusable, apply to as many elements as you want. ID (#name) = unique, only ONE element per page can have a given ID."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does this CSS rule do? p.shade { background: red; }",
                        options: [
                            "Makes all <p> tags have a red background",
                            "Makes all elements with class='shade' have a red background",
                            "Makes only <p> tags that also have class='shade' have a red background",
                            "Makes the paragraph named 'shade' have a red background"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Combining a tag name with a class (p.shade) targets ONLY that specific element type with that class. A bare .shade would match any element with class='shade'."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the difference between <span> and <div>?",
                        options: [
                            "span is for images; div is for text",
                            "span is an inline element (no line break); div is a block element (starts new line)",
                            "span applies to the whole page; div only to one section",
                            "They are identical — use either one"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "<span> wraps inline content (like a word inside a sentence). <div> is a block-level container that starts on a new line. Both have no default styling — they're CSS's best friends."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which CSS property sets the font for an entire web page?",
                        options: [
                            "page-font: Arial;",
                            "font-face: Arial;",
                            "body { font-family: Arial; }",
                            "all { font: Arial; }"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Applying font-family to the body selector cascades to all child elements on the page. Always include fallback fonts: body { font-family: Arial, Helvetica, sans-serif; }"
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Two CSS rules conflict: h2 { color: green; } then h2 { color: purple; }. What color is the h2?",
                        options: [
                            "Green — first rule wins",
                            "Purple — last rule wins",
                            "A mix of green and purple",
                            "The browser shows an error"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "When CSS rules conflict (same selector, same property), the LAST rule listed wins. This is the 'cascading' in Cascading Style Sheets."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 9",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which CSS selector correctly targets ONLY <h1> tags that have id='intro'?",
                        options: [".intro { }", "#intro { }", "h1.intro { }", "h1#intro { }"],
                        correctAnswerIndex: 3,
                        explanation: "h1#intro combines the element name with the ID selector — it only matches an h1 that has id='intro'. Just #intro would match any element with that ID."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 10",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which font type is generally recommended for text to be read on-screen?",
                        options: [
                            "Serif (e.g. Times New Roman, Georgia)",
                            "Sans-Serif (e.g. Verdana, Arial)",
                            "Monospace (e.g. Courier New)",
                            "Decorative (e.g. Comic Sans)"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Sans-serif fonts (no 'feet' on letters) are cleaner and easier to read on screen. Serif fonts are traditionally better for print. Verdana and Arial were specifically designed for screen readability."
                    )
                ),
            ]
        ),

        // ════════════════════════════════════════════════════════
        // MODULE 4: Images & Media  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: Adding Images ──────────────────────
        Lesson(
            id: 16,
            title: "Adding Images",
            description: "Insert images into your pages using <img>, src, alt, and size attributes",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 15,
            moduleTitle: "Module 4: Images & Media",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "The <img> Tag",
                    content: """
                    Images on the web are NOT embedded inside the HTML file like in a Word document. The browser loads them as **separate files** at the same time as the HTML.

                    The `<img>` tag is **self-closing** (no </img> needed):
                    ```
                    <img src="photo.jpg" alt="A golden retriever" />
                    ```

                    🔑 Key attributes:
                    **src** — source path to the image file (relative or absolute URL)
                    **alt** — alternative text shown if image fails to load; also read by screen readers
                    **width** — image width in pixels: `width="300"`
                    **height** — image height in pixels: `height="200"`

                    📌 **alt is required** — it's an accessibility and SEO must-have. Never leave it empty.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Images with Paths",
                    content: "💡 Relative and absolute paths — always store your images in a /graphics/ subfolder:",
                    codeExample: """
                    File structure:
                    my-website/
                    ├── index.html
                    └── graphics/
                        ├── logo.png
                        └── hero.jpg

                    In index.html:
                    <!-- Relative path — image in subfolder -->
                    <img src="graphics/logo.png" alt="WebCraft Logo" />
                    <img src="graphics/hero.jpg" alt="Homepage hero" width="800" height="400" />

                    <!-- Absolute path — image hosted elsewhere -->
                    <img src="https://example.com/banner.gif" alt="Banner" />

                    <!-- Tip: setting only width lets height auto-scale -->
                    <img src="graphics/photo.jpg" alt="Photo" width="400" />
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: Image Formats ──────────────────────
        Lesson(
            id: 17,
            title: "Image Formats",
            description: "Know when to use GIF, JPEG, or PNG — choosing wrong increases file size and breaks quality",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 16,
            moduleTitle: "Module 4: Images & Media",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "GIF, JPEG & PNG",
                    content: """
                    Three formats dominate the web. Choosing the right one matters — wrong choice = bigger files, worse quality.

                    **GIF** (.gif)
                    • 256 colors maximum — NOT good for photos
                    • Supports transparency (one color set as transparent)
                    • Supports animation (multiple frames)
                    • Best for: icons, logos, line art, simple graphics, animations

                    **JPEG** (.jpg / .jpeg)
                    • 16 million colors — excellent for photos
                    • **Lossy** compression — discards some data to shrink file size
                    • Each save degrades quality slightly — always edit from the original
                    • No transparency, no animation
                    • Best for: photographs, complex images with gradients

                    **PNG** (.png)
                    • Lossless — no quality lost when compressed
                    • Supports transparency (much better than GIF)
                    • No animation support
                    • Slightly larger files than JPEG for photos
                    • Best for: screenshots, logos needing transparency, graphics with text
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Format Decision Guide",
                    content: "💡 Quick reference — ask these questions to pick the right format:",
                    codeExample: """
                    Photo of a person or landscape?
                      → JPEG (.jpg)

                    Logo, icon, or line art on a colored background?
                      → GIF (.gif)

                    Image that needs a transparent background?
                      → PNG (.png)  or  GIF (.gif)

                    Animated graphic?
                      → GIF (.gif)
                      → Modern alternative: CSS animation or <video>

                    Screenshot with text / UI element?
                      → PNG (.png)  ← lossless keeps text crisp

                    ⚠️ JPEG is LOSSY — never edit and re-save repeatedly.
                       Always keep the original and export a fresh copy.
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: Finding & Creating Images ──────────
        Lesson(
            id: 18,
            title: "Finding & Creating Images",
            description: "Source images responsibly — free archives, your own photos, and web-optimised exports",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 17,
            moduleTitle: "Module 4: Images & Media",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Where to Get Images",
                    content: """
                    You have three options for getting images onto your site:

                    **1. Use existing images (with permission)**
                    • Free archives: commons.wikimedia.org, flickr.com/creativecommons
                    • Always check the usage license before using any image
                    • To download: right-click → Save Image As → save to your `/graphics/` folder

                    **2. Create your own graphics**
                    • Tools: Adobe Photoshop, Figma, or free web-based tools like Pixlr (pixlr.com)
                    • Edit in native format (BMP/PICT) first
                    • THEN export a copy as GIF/JPEG/PNG — never edit the exported file directly

                    **3. Digitize photos**
                    • Scanner → save as JPEG/GIF → clean up in Photoshop if needed
                    • Modern phones save as JPEG automatically — resize before uploading

                    🖼️ **Web image best practices:**
                    • Save at **75–150 dpi** — screens can only show ~72–96 dpi, anything above is wasted
                    • Smaller file size = faster page load — compress images before uploading
                    • Only use images you have **permission** to use
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: Background Images & URLs ───────────
        Lesson(
            id: 19,
            title: "Background Images & URLs",
            description: "Add background images with CSS and master the full URL protocol cheatsheet",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 18,
            moduleTitle: "Module 4: Images & Media",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "CSS Background Images",
                    content: """
                    Background images tile across the browser window. They must be used carefully — a bad background makes text nearly unreadable.

                    **CSS method (preferred):**
                    ```
                    body {
                      background: url(images/texture.jpg);
                    }
                    ```

                    **With advanced options:**
                    ```
                    body {
                      background-image: url(images/bg.png);
                      background-repeat: no-repeat;  /* repeat | repeat-x | repeat-y */
                      background-size: cover;          /* scale to fill entire window */
                      background-color: #ffffff;       /* fallback if image fails */
                    }
                    ```

                    ❌ **Old HTML method (avoid):**
                    ```
                    <body background="images/texture.jpg">
                    ```

                    📌 **Background design rules:**
                    • Keep contrast HIGH between text and background
                    • Keep the background SIMPLE — busy patterns make text hard to read
                    • Use sparingly — overusing backgrounds looks unprofessional
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "URL Protocol Cheatsheet",
                    content: "💡 Not all URLs start with http:// — here's the full reference:",
                    codeExample: """
                    Protocol     | What it's used for
                    -------------|--------------------------------------
                    http://      | Standard web page
                    https://     | Secure encrypted web page (use this!)
                    ftp://       | File Transfer Protocol site
                    mailto:      | Opens email client to send a message
                    file:///     | File on local computer only

                    Examples:
                    <a href="https://example.com">Website</a>
                    <a href="mailto:you@example.com">Email Me</a>
                    <a href="ftp://files.example.com">Download Files</a>

                    Always prefer https:// over http:// for security.
                    mailto: is great for contact links on portfolio sites!
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 5: Module 4 Quiz ──────────────────────
        Lesson(
            id: 20,
            title: "Module 4 Quiz",
            description: "10 questions on images, formats, and URLs — earn your 650 XP!",
            difficulty: .beginner,
            xpReward: 650,
            prerequisiteId: 19,
            moduleTitle: "Module 4: Images & Media",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "How does a web page display an image, compared to a Word document?",
                        options: [
                            "The image is embedded directly inside the HTML file",
                            "The HTML file points to a separate image file; the browser fetches them independently",
                            "The image is converted to text code and stored in the HTML",
                            "The image is downloaded to the user's computer permanently"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Web images are always separate files. The HTML <img> tag is just a pointer saying 'load this file here.' The browser makes a separate request for each image on the page."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which attribute in the <img> tag specifies WHERE the image file is located?",
                        options: ["href", "src", "alt", "url"],
                        correctAnswerIndex: 1,
                        explanation: "src = source. It contains the path (relative or absolute URL) to the image file. href is used by anchor <a> tags for links, not images."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "You have a photo of your dog to put on your website. Which image format is BEST?",
                        options: [
                            "GIF — it supports the most colors",
                            "JPEG — designed for photos with rich color",
                            "PNG — smallest file size",
                            "BMP — highest quality"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "JPEG was specifically designed for photographs with high color depth (24-bit = 16M colors). GIF is limited to 256 colors — terrible for photos."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which image format supports BOTH transparency AND animation?",
                        options: ["JPEG", "BMP", "GIF", "PNG"],
                        correctAnswerIndex: 2,
                        explanation: "GIF supports both transparency (one color set as transparent) and animation (multiple frames). PNG supports transparency but NOT animation. JPEG supports neither."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Your HTML file is at my-site/index.html and your image is at my-site/graphics/logo.png. Which src is correct?",
                        options: [
                            "src=\"logo.png\"",
                            "src=\"/logo.png\"",
                            "src=\"graphics/logo.png\"",
                            "src=\"../graphics/logo.png\""
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Since the image is in a subfolder called 'graphics' relative to your HTML file, you write graphics/logo.png. No ../ needed because you're not going up a level."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does the alt attribute in an <img> tag do?",
                        options: [
                            "Sets the image file name",
                            "Provides text shown when the image fails to load (also used by screen readers)",
                            "Adjusts the image width",
                            "Specifies the image format"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "alt = alternative text. It shows when an image can't load, helps visually impaired users with screen readers, and improves SEO. It's required for accessibility compliance."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which image format uses 'lossy' compression?",
                        options: ["GIF", "PNG", "JPEG", "BMP"],
                        correctAnswerIndex: 2,
                        explanation: "JPEG is lossy — it discards some image data during compression to make smaller files. Each time you save a JPEG, quality decreases slightly. Always edit from the original source file."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the recommended DPI range when saving images for websites?",
                        options: [
                            "300–600 dpi (same as print)",
                            "1–25 dpi",
                            "75–150 dpi",
                            "500+ dpi for maximum quality"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Screens can only display ~72–96 dpi. Anything above 150 dpi is wasted on web — it makes the file larger without any visible quality improvement. High DPI is for print."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 9",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which is the CORRECT way to add a background image using CSS?",
                        options: [
                            "<body background-css=\"image.jpg\">",
                            "body { background-image = \"url(image.jpg)\"; }",
                            "body { background: url(image.jpg); }",
                            "<style background=\"image.jpg\">"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "CSS syntax: property: value; The background shorthand takes url() as its value. Note the colon (not =) and the url() function wrapper around the image path."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 10",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which protocol would you use in a URL to let visitors send you an email by clicking a link?",
                        options: ["http://", "ftp://", "file:///", "mailto:"],
                        correctAnswerIndex: 3,
                        explanation: "mailto: is a special protocol that opens the visitor's default email client with your address pre-filled. Example: <a href='mailto:you@example.com'>Email Me</a>"
                    )
                ),
            ]
        ),

        // ════════════════════════════════════════════════════════
        // MODULE 5: Imagemaps, Media & Tables  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: Imagemaps ──────────────────────────
        Lesson(
            id: 21,
            title: "Imagemaps",
            description: "Turn any image into a clickable map with multiple hotspot destinations",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 20,
            moduleTitle: "Module 5: Imagemaps, Media & Tables",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "What is an Imagemap?",
                    content: """
                    An imagemap lets you define **clickable regions** (hotspots) on a single image, each linking to a different destination — like a map with clickable countries.

                    You need two things:
                    1. A `<map>` element containing `<area>` tags that define the hotspots
                    2. A `usemap` attribute on the `<img>` tag that links it to the map

                    **Three hotspot shapes:**
                    **rect** — rectangle: `coords="left,top,right,bottom"`
                    **circle** — circle: `coords="centerX,centerY,radius"`
                    **poly** — polygon: `coords="x1,y1,x2,y2,x3,y3,..."`
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Imagemap Example",
                    content: "💡 A complete imagemap with all three shape types:",
                    codeExample: """
                    <!-- Link the image to the map with usemap -->
                    <img src="world.jpg" alt="World map"
                         usemap="#worldmap" />

                    <!-- Define the map (# must match usemap value) -->
                    <map name="worldmap">

                      <!-- Rectangle: left,top,right,bottom -->
                      <area shape="rect"
                            coords="0,0,200,100"
                            href="north-america.html"
                            alt="North America" />

                      <!-- Circle: centerX,centerY,radius -->
                      <area shape="circle"
                            coords="300,150,50"
                            href="europe.html"
                            alt="Europe" />

                      <!-- Polygon: x1,y1,x2,y2,x3,y3 -->
                      <area shape="poly"
                            coords="400,50,450,100,350,100"
                            href="asia.html"
                            alt="Asia" />

                    </map>
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: Audio & Video ──────────────────────
        Lesson(
            id: 22,
            title: "Audio & Video",
            description: "Embed sound and video natively with HTML5 <audio> and <video> — no plugins needed",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 21,
            moduleTitle: "Module 5: Imagemaps, Media & Tables",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "HTML5 Audio & Video",
                    content: """
                    HTML5 introduced native `<audio>` and `<video>` tags — no Flash or plugins needed. Browsers handle playback directly.

                    **<audio> tag:**
                    ```
                    <audio controls>
                      <source src="song.mp3" type="audio/mpeg" />
                      <source src="song.ogg" type="audio/ogg" />
                      Your browser does not support audio.
                    </audio>
                    ```

                    **<video> tag:**
                    ```
                    <video controls width="640" height="360">
                      <source src="movie.mp4" type="video/mp4" />
                      <source src="movie.webm" type="video/webm" />
                      Your browser does not support video.
                    </video>
                    ```

                    �� Key attributes:
                    **controls** — show play/pause/volume buttons
                    **autoplay** — start playing immediately on page load
                    **loop** — repeat when finished
                    **muted** — start muted (required for autoplay in most browsers)

                    📌 Always provide **multiple source formats** as fallbacks:
                    • Audio: MP3 + OGG
                    • Video: MP4 + WebM

                    Old approach (avoid): `<a href="file.mp3">Play</a>` — no controls, just a link.
                    Older approach (avoid): `<embed>` — requires plugins, unreliable.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: Lists ───────────────────────────────
        Lesson(
            id: 23,
            title: "HTML Lists",
            description: "Create ordered, unordered, and nested lists to organize any kind of content",
            difficulty: .beginner,
            xpReward: 100,
            prerequisiteId: 22,
            moduleTitle: "Module 5: Imagemaps, Media & Tables",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Unordered & Ordered Lists",
                    content: """
                    **Unordered list** `<ul>` — bullet points:
                    ```
                    <ul type="disc">   <!-- disc | circle | square -->
                      <li>HTML</li>
                      <li>CSS</li>
                      <li>JavaScript</li>
                    </ul>
                    ```
                    Default bullet type is **disc** (filled circle).

                    **Ordered list** `<ol>` — numbered/lettered:
                    ```
                    <ol type="1" start="1">   <!-- 1 | a | A | i | I -->
                      <li>Plan your site</li>
                      <li>Write the HTML</li>
                      <li>Add CSS</li>
                    </ol>
                    ```
                    • `type="1"` → 1, 2, 3 (default)
                    • `type="a"` → a, b, c
                    • `type="A"` → A, B, C
                    • `type="i"` → i, ii, iii
                    • `type="I"` → I, II, III
                    • `start="4"` → begin numbering at 4 (always a number, even with letter types)

                    📌 Tip: `<ol type="A" start="3">` → first item is **C** (3rd letter)
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Nested Lists",
                    content: "💡 Lists can be nested inside `<li>` tags to any depth:",
                    codeExample: """
                    <ol type="I">
                      <li>Introduction</li>
                      <li>Thesis 1
                        <ol type="A">
                          <li>Point A
                            <ol type="1">
                              <li>Subpoint 1</li>
                              <li>Subpoint 2</li>
                            </ol>
                          </li>
                          <li>Point B</li>
                        </ol>
                      </li>
                      <li>Thesis 2</li>
                    </ol>

                    Result:
                    I.  Introduction
                    II. Thesis 1
                        A. Point A
                           1. Subpoint 1
                           2. Subpoint 2
                        B. Point B
                    III. Thesis 2
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: HTML Tables ─────────────────────────
        Lesson(
            id: 24,
            title: "HTML Tables",
            description: "Organize data into rows and columns using <table>, <tr>, <td>, and <th>",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 23,
            moduleTitle: "Module 5: Imagemaps, Media & Tables",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Table Structure",
                    content: """
                    HTML tables organize information into rows and columns — like a spreadsheet inside your webpage. Ideal for schedules, price lists, comparison charts, and statistics.

                    **Core tags:**
                    **<table>** — wraps the entire table (outer container)
                    **<tr>** — table row (one horizontal row)
                    **<td>** — table data cell (regular cell inside a row)
                    **<th>** — table header cell (bold + centered by default)
                    **<caption>** — a title displayed above the table

                    **Key attributes:**
                    **border** — border thickness in pixels (0 = hidden)
                    **width** — table or cell width in pixels or %
                    **cellpadding** — space between cell content and edge
                    **cellspacing** — space between cells
                    **bgcolor** — background color of table/row/cell
                    **align** — horizontal alignment: left, center, right
                    **valign** — vertical alignment: top, middle, bottom

                    📌 **Structure rule:** `<table>` → `<tr>` → `<td>` or `<th>`
                    You CANNOT put a `<td>` directly inside `<table>`. It must be inside a `<tr>` first.

                    📜 **Historical note:** Before CSS, tables were used for page layout.
                    Today: use CSS for layout, tables only for actual tabular data.
                    Exception: HTML email newsletters (Outlook has poor CSS support).
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Complete Table Example",
                    content: "💡 A complete table with headers, data rows, and a caption:",
                    codeExample: """
                    <table border="1" cellpadding="8" cellspacing="0">
                      <caption>Beanie Babies Collection</caption>

                      <!-- Header row -->
                      <tr>
                        <th>Bear Name</th>
                        <th>Country</th>
                        <th>Year Released</th>
                      </tr>

                      <!-- Data rows -->
                      <tr>
                        <td>Glory</td>
                        <td>USA</td>
                        <td>1997</td>
                      </tr>
                      <tr bgcolor="#f0f0f0">
                        <td>Osito</td>
                        <td>Mexico</td>
                        <td>1999</td>
                      </tr>
                    </table>
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 5: Module 5 Quiz ───────────────────────
        Lesson(
            id: 25,
            title: "Module 5 Quiz",
            description: "10 questions on imagemaps, audio/video, lists, and tables — earn 750 XP!",
            difficulty: .intermediate,
            xpReward: 750,
            prerequisiteId: 24,
            moduleTitle: "Module 5: Imagemaps, Media & Tables",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What HTML tag is used to display an image on a web page?",
                        options: ["<picture>", "<image>", "<img>", "<graphic>"],
                        correctAnswerIndex: 2,
                        explanation: "The <img> tag is the correct HTML element for embedding images. It is self-closing and requires src and alt attributes."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "In an imagemap, what attribute on the <img> tag links it to a <map> element named 'mymap'?",
                        options: ["id=\"mymap\"", "href=\"#mymap\"", "usemap=\"#mymap\"", "maplink=\"mymap\""],
                        correctAnswerIndex: 2,
                        explanation: "The usemap attribute connects the image to a <map> element. The value must start with # followed by the map's name attribute value."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "You want a circular hotspot centered at (80,60) with radius 25. Which area tag is correct?",
                        options: [
                            "<area shape=\"circle\" coords=\"80,60,25\" href=\"page.html\" />",
                            "<area shape=\"circle\" coords=\"80,60,80,60,25\" href=\"page.html\" />",
                            "<area shape=\"rect\" coords=\"80,60,25\" href=\"page.html\" />",
                            "<area shape=\"circle\" coords=\"25,80,60\" href=\"page.html\" />"
                        ],
                        correctAnswerIndex: 0,
                        explanation: "For a circle, coords format is: centerX, centerY, radius. So (80,60) is the center and 25 is the radius."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which method of embedding media causes the fastest initial page load?",
                        options: ["<embed> tag", "<video> tag", "Anchor <a> tag linking to the file", "<object> tag"],
                        correctAnswerIndex: 2,
                        explanation: "Using a regular <a href> link means the media file is not downloaded until the user clicks — resulting in fast initial page loads."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which HTML5 tag is the modern, plug-in-free way to embed a video directly in a web page?",
                        options: ["<embed>", "<video>", "<object>", "<media>"],
                        correctAnswerIndex: 1,
                        explanation: "HTML5 introduced the <video> element which works natively in all modern browsers without requiring Flash or other plug-ins."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the default bullet style for an unordered list <ul>?",
                        options: ["square", "circle", "disc", "arrow"],
                        correctAnswerIndex: 2,
                        explanation: "The default type for <ul> is disc — a filled circle bullet point. You can change it with type='circle' or type='square'."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "You write <ol type=\"A\" start=\"3\">. What will the first item be labeled?",
                        options: ["A.", "3.", "C.", "1."],
                        correctAnswerIndex: 2,
                        explanation: "start is always a number. start='3' means begin at the 3rd item. With type='A', the 3rd letter is C."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What HTML tag defines a single horizontal row inside a table?",
                        options: ["<table>", "<td>", "<th>", "<tr>"],
                        correctAnswerIndex: 3,
                        explanation: "<tr> stands for 'table row'. It wraps all the cells (<td> or <th> elements) in one horizontal row of the table."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 9",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the difference between <td> and <th> in a table?",
                        options: [
                            "They are identical",
                            "<th> is bold and centered by default; <td> is a regular data cell",
                            "<td> creates the table; <th> creates rows",
                            "<th> can only be used in the first row"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "<th> = table header — bold and centered by default. <td> = table data — plain cell. Both go inside <tr> rows."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 10",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "When is it still acceptable to use HTML tables for page layout (not just data)?",
                        options: [
                            "Always — tables are fine for all layouts",
                            "Never — tables should only hold pure data",
                            "For HTML email newsletters, since email clients don't fully support CSS",
                            "Only when using tables with border='0'"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "The W3C recommended in 2002 to stop using tables for web page layout in favour of CSS. HTML emails are an exception because email clients like Outlook have poor CSS support."
                    )
                ),
            ]
        ),

        // ════════════════════════════════════════════════════════
        // MODULE 6: Advanced CSS  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: Advanced Selectors ─────────────────
        Lesson(
            id: 26,
            title: "Advanced Selectors",
            description: "Master grouping, contextual, child, adjacent selectors and link pseudo-classes",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 25,
            moduleTitle: "Module 6: Advanced CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Beyond Basic Selectors",
                    content: """
                    You already know element, class, and ID selectors. Advanced selectors let you target elements with surgical precision.

                    **Group selector** — same rules for multiple elements:
                    ```
                    h1, h2, h3 { color: #1a1a2e; font-family: Georgia, serif; }
                    ```

                    **Contextual (descendant)** — only when nested inside another:
                    ```
                    ul li em { color: red; }
                    /* em is red ONLY when inside li inside ul */
                    ```

                    **Direct child (>)** — only immediate children:
                    ```
                    h1 > strong { color: purple; }
                    /* strong only if directly inside h1, not deeper */
                    ```

                    **Adjacent sibling (+)** — immediately after another:
                    ```
                    h2 + a { color: green; }
                    /* link is green ONLY right after an h2 */
                    ```

                    **Comments:**
                    ```
                    /* CSS comment — ignored by browser */
                    <!-- Only use this in .html files, NOT .css files -->
                    ```
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .theory,
                    title: "Pseudo-classes & Generated Content",
                    content: """
                    **Pseudo-elements** — style just part of an element:
                    ```
                    p:first-letter { font-size: 2em; }  /* big drop cap */
                    p:first-line   { color: blue; }     /* first line only */
                    ```

                    **Link pseudo-classes** — style links by state:
                    ```
                    a:link    { color: blue; }    /* unvisited link */
                    a:visited { color: purple; }  /* already visited */
                    a:hover   { color: red; }     /* mouse hovering */
                    a:active  { color: orange; }  /* being clicked */
                    ```

                    **Generated content** — insert icons/text via CSS:
                    ```
                    a.pdf:after  { content: url("pdf.gif"); }
                    a.word:before { content: url("word.gif"); }
                    ```
                    This inserts images automatically after/before PDF or Word links — no HTML changes needed.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: Fonts, Colors & Backgrounds ────────
        Lesson(
            id: 27,
            title: "Fonts, Colors & Backgrounds",
            description: "Master all CSS font properties, four color formats, and background styling",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 26,
            moduleTitle: "Module 6: Advanced CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "CSS Font Properties",
                    content: """
                    Every typographic detail is controllable with CSS:

                    **font-family** — which font(s) to use:
                    ```
                    p { font-family: Verdana, Arial, sans-serif; }
                    ```

                    **font-style** — normal or italic:
                    ```
                    h1 { font-style: italic; }
                    ```

                    **font-weight** — thickness:
                    ```
                    b { font-weight: bolder; }   /* bold | bolder | 100-900 */
                    ```

                    **font-size** — text size:
                    ```
                    body { font-size: large; }   /* px | em | % | keywords */
                    p    { font-size: 16px; }
                    h1   { font-size: 2em; }     /* 2x current size */
                    ```

                    **font-variant** — small caps:
                    ```
                    em { font-variant: small-caps; }
                    ```

                    **text-shadow** — drop shadow on text:
                    ```
                    .cool { text-shadow: #f00 3px 3px 5px; }
                    /* color  x-offset  y-offset  blur */
                    ```
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Four Color Formats & Backgrounds",
                    content: "💡 All four CSS color formats produce the same red — use whichever you prefer:",
                    codeExample: """
                    /* All four produce identical red: */
                    color: #ff0000;      /* 6-digit hex */
                    color: #f00;         /* 3-digit hex shorthand */
                    color: rgb(255,0,0); /* RGB integer values */
                    color: red;          /* keyword name */

                    /* Background color */
                    body { background-color: #f5f5f5; }

                    /* Background image */
                    body { background-color: #f00; }
                    table { background-image: url("/images/bg.gif"); }

                    /* Background shorthand */
                    body {
                      background: url(images/bg.jpg) no-repeat center / cover;
                      background-color: #ffffff; /* fallback */
                    }
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: The Box Model ───────────────────────
        Lesson(
            id: 28,
            title: "The Box Model",
            description: "Every element is a box — understand margin, border, padding, and how to center elements",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 27,
            moduleTitle: "Module 6: Advanced CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Margin, Border, Padding, Content",
                    content: """
                    Every HTML element lives inside an invisible rectangular box. From outside in:

                    ```
                    ← MARGIN  (space outside the border)     →
                    ← BORDER  (the visible/invisible edge)   →
                    ← PADDING (space inside, around content) →
                        CONTENT
                    ```

                    **margin** — space outside the border (separates elements from each other)
                    **border** — the visible (or invisible) edge
                    **padding** — space inside the border, between border and content
                    **width / height** — size of the content area only

                    📌 **Centering a block element:**
                    ```
                    #main {
                      width: 80%;
                      margin-left: auto;
                      margin-right: auto;
                      /* shorthand: margin: 0 auto; */
                    }
                    ```
                    Set a width, then auto margins push it to the center.

                    **Block vs Inline — CSS lets you override the default:**
                    ```
                    em { display: block; }   /* inline → acts like block */
                    p  { display: inline; }  /* block → flows with text */
                    .hidden { display: none; } /* element disappears entirely */
                    ```
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: Positioning & Float ────────────────
        Lesson(
            id: 29,
            title: "Positioning & Float",
            description: "Control exactly where elements appear with absolute/fixed positioning, z-index, and float",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 28,
            moduleTitle: "Module 6: Advanced CSS",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "Absolute, Fixed & Z-Index",
                    content: """
                    **Absolute positioning** — places element at exact pixel coordinates relative to its nearest positioned parent:
                    ```
                    #header {
                      position: absolute;
                      top: 0px;
                      left: 0px;
                      width: 100%;
                    }
                    ```

                    **Fixed positioning** — stays in place even when page scrolls (great for sticky nav bars):
                    ```
                    #sidebar {
                      position: fixed;
                      top: 20px;
                      left: 0px;
                      width: 200px;
                    }
                    ```

                    **z-index** — controls which overlapping element appears on top. Higher number = on top:
                    ```
                    #box1 { position: absolute; z-index: 5; } /* on top */
                    #box2 { position: absolute; z-index: 1; } /* behind */
                    ```
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
                LessonSection(
                    type: .example,
                    title: "Float, Clear & Nav Bar Pattern",
                    content: "💡 Float wraps text around an element. Clear stops the wrap. Together they build nav bars:",
                    codeExample: """
                    /* Float an image left — text wraps to the right */
                    img { float: left; margin: 0 12px 8px 0; }

                    /* Clear ends all floats — nothing floats past this */
                    .footer { clear: both; }

                    /* Nav bar using CSS lists — make items horizontal */
                    li {
                      list-style-type: none;  /* remove bullet */
                      display: inline;         /* flow side by side */
                      padding: 5px 10px;
                      border: thin solid #000;
                    }

                    /* Hover effect for nav links */
                    nav a:hover {
                      background-color: #5E6AD2;
                      color: white;
                    }
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 5: Module 6 Quiz ───────────────────────
        Lesson(
            id: 30,
            title: "Module 6 Quiz",
            description: "8 questions on advanced CSS selectors, box model, and positioning — earn 800 XP!",
            difficulty: .intermediate,
            xpReward: 800,
            prerequisiteId: 29,
            moduleTitle: "Module 6: Advanced CSS",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does CSS stand for?",
                        options: ["Creative Styling System", "Cascading Style Sheets", "Computer Style Standard", "Content Styling Sheet"],
                        correctAnswerIndex: 1,
                        explanation: "CSS = Cascading Style Sheets. Cascading means rules flow top-to-bottom and the last conflicting rule wins."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What symbol starts a CSS class selector?",
                        options: ["#", "@", ".", "!"],
                        correctAnswerIndex: 2,
                        explanation: "Class selectors start with a dot: .highlight { }. ID selectors start with #."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which selector targets a <strong> element ONLY when it is directly inside an <h1>?",
                        options: ["ul li em { }", "h1 > strong { }", "h2 + a { }", "a:hover { }"],
                        correctAnswerIndex: 1,
                        explanation: "The > symbol is the direct child combinator — only works if strong is immediately inside h1, not nested deeper."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "From outside to inside, what is the correct order of the CSS box model?",
                        options: [
                            "Content → Padding → Border → Margin",
                            "Margin → Padding → Border → Content",
                            "Margin → Border → Padding → Content",
                            "Border → Margin → Padding → Content"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Think of layers of a box: margin (outside gap) > border (the edge) > padding (inside gap) > content."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "How do you center a block element using CSS?",
                        options: ["text-align: center", "margin: 0 auto (with a set width)", "float: center", "align: center"],
                        correctAnswerIndex: 1,
                        explanation: "Set a width first, then use margin-left: auto and margin-right: auto (shorthand: margin: 0 auto). text-align only centers inline content inside a block."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which position value keeps an element visible even when the page scrolls?",
                        options: ["absolute", "relative", "sticky", "fixed"],
                        correctAnswerIndex: 3,
                        explanation: "position: fixed locks the element to the viewport — it never scrolls away. Great for sticky navigation bars."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What CSS property determines which overlapping element appears on top?",
                        options: ["layer", "z-index", "order", "depth"],
                        correctAnswerIndex: 1,
                        explanation: "Higher z-index = closer to the viewer. Both elements must have position: absolute or position: fixed for z-index to work."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which CSS pseudo-class applies when the user's mouse is hovering over a link?",
                        options: ["a:link", "a:visited", "a:hover", "a:active"],
                        correctAnswerIndex: 2,
                        explanation: "a:hover fires when the mouse is over the element. a:link = unvisited, a:visited = already visited, a:active = being clicked right now."
                    )
                ),
            ]
        ),

        // ════════════════════════════════════════════════════════
        // MODULE 7: HTML Forms  — 5 Sub-Lessons
        // ════════════════════════════════════════════════════════

        // ── SUB-LESSON 1: The <form> Tag ──────────────────────
        Lesson(
            id: 31,
            title: "The <form> Tag",
            description: "Learn how HTML forms work, GET vs POST, and how the action attribute sends data to a server",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 30,
            moduleTitle: "Module 7: HTML Forms",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "How Forms Work",
                    content: """
                    Every form on the web has two parts:
                    1. **HTML** — what the user sees and fills in
                    2. **CGI script** (PHP, Python, etc.) — runs on the server and processes the submission

                    The `<form>` tag wraps all form elements. Its two key attributes:

                    **METHOD** — how to send data:
                    ```
                    method="GET"   Appends data to the URL
                                   Visible in address bar
                                   Good for searches, limited data

                    method="POST"  Sends data separately (hidden)
                                   Preferred for most forms
                                   Handles large or sensitive data
                    ```

                    **ACTION** — where to send data (the server script URL):
                    ```
                    <form method="POST" action="process.php">
                      [ form fields go here ]
                    </form>
                    ```

                    💡 GET example — URL looks like:
                    `https://site.com/search?q=hello&lang=en`
                    POST sends the same data invisibly in the request body.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 2: Input Types ─────────────────────────
        Lesson(
            id: 32,
            title: "Input Types",
            description: "Master every <input> type: text, password, radio, checkbox, submit, reset, and hidden",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 31,
            moduleTitle: "Module 7: HTML Forms",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "The <input> Tag",
                    content: """
                    The `<input>` tag is the most common form element. The **type** attribute controls what appears. Every input needs a **name** so the server can identify the data.

                    **text** — single-line text box:
                    ```
                    <input type="text" name="firstname"
                           size="40" maxlength="40"
                           value="Enter Name" />
                    ```

                    **password** — hides characters as ●●●●:
                    ```
                    <input type="password" name="pass"
                           size="10" maxlength="10" />
                    ```
                    ⚠️ Still sent as plain text unless HTTPS is used!

                    **radio** — pick ONE from a group (same name):
                    ```
                    <input type="radio" name="color" value="red" /> Red
                    <input type="radio" name="color" value="blue"
                           checked="checked" /> Blue
                    ```

                    **checkbox** — pick ANY number:
                    ```
                    <input type="checkbox" name="fruit" value="apple" /> Apple
                    <input type="checkbox" name="fruit" value="mango"
                           checked="checked" /> Mango
                    ```

                    **hidden** — sends invisible data to the server:
                    ```
                    <input type="hidden" name="source" value="homepage" />
                    ```

                    **submit & reset:**
                    ```
                    <input type="submit" value="Send My Message" />
                    <input type="reset"  value="Start Over" />
                    ```
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 3: Textarea & Select ──────────────────
        Lesson(
            id: 33,
            title: "Textarea & Select",
            description: "Create multi-line text boxes with <textarea> and dropdown menus with <select>",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 32,
            moduleTitle: "Module 7: HTML Forms",
            sections: [
                LessonSection(
                    type: .theory,
                    title: "<textarea> & <select>",
                    content: """
                    **<textarea>** — multi-line text input (comments, messages):
                    ```
                    <textarea name="comments" rows="4"
                              cols="40" wrap="virtual">
                      Enter your comments here...
                    </textarea>
                    ```
                    **rows** — height in text lines
                    **cols** — width in characters
                    **wrap="off"** — no wrapping, one long line
                    **wrap="soft"** — wraps visually; sent as one line
                    **wrap="hard"** — wraps visually; line breaks included when sent

                    ---

                    **<select>** — dropdown or list box:
                    ```
                    <!-- Dropdown (default) -->
                    <select name="color">
                      <option value="red">Red</option>
                      <option value="blue" selected="selected">Blue</option>
                    </select>

                    <!-- List box (add size) -->
                    <select name="color" size="3">
                      <!-- shows 3 items at once -->

                    <!-- Allow multiple selections -->
                    <select name="foods" multiple="multiple">
                    ```
                    Ctrl/Cmd + click to select multiple options.
                    """,
                    codeExample: nil,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 4: Complete Form Example ──────────────
        Lesson(
            id: 34,
            title: "Complete Form Example",
            description: "Build a full contact form combining all input types, textarea, select, and radio buttons",
            difficulty: .intermediate,
            xpReward: 100,
            prerequisiteId: 33,
            moduleTitle: "Module 7: HTML Forms",
            sections: [
                LessonSection(
                    type: .example,
                    title: "Full Contact Form",
                    content: "💡 A complete form combining all major input types:",
                    codeExample: """
                    <form method="POST" action="process.php">

                      Name:
                      <input type="text" name="name" size="30" />

                      Email:
                      <input type="text" name="email" size="30" />

                      Password:
                      <input type="password" name="pw" size="15" />

                      Favorite Color:
                      <input type="radio" name="color" value="red" /> Red
                      <input type="radio" name="color" value="blue" /> Blue

                      Operating System:
                      <select name="os">
                        <option value="mac">Mac</option>
                        <option value="win">Windows</option>
                        <option value="linux">Linux</option>
                      </select>

                      Newsletter topics (pick any):
                      <input type="checkbox" name="topic" value="html" /> HTML
                      <input type="checkbox" name="topic" value="css" /> CSS

                      Comments:
                      <textarea name="msg" rows="4" cols="40"></textarea>

                      <!-- Hidden tracking field -->
                      <input type="hidden" name="source" value="homepage" />

                      <input type="submit" value="Send Message" />
                      <input type="reset"  value="Clear Form" />

                    </form>
                    """,
                    challenge: nil
                ),
            ]
        ),

        // ── SUB-LESSON 5: Module 7 Quiz ───────────────────────
        Lesson(
            id: 35,
            title: "Module 7 Quiz",
            description: "8 questions on HTML forms, input types, and data submission — earn 750 XP!",
            difficulty: .intermediate,
            xpReward: 750,
            prerequisiteId: 34,
            moduleTitle: "Module 7: HTML Forms",
            sections: [
                LessonSection(
                    type: .quiz,
                    title: "Question 1",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What are the two required parts of any HTML form?",
                        options: [
                            "HTML + CSS",
                            "HTML + CGI script",
                            "<form> tag + <input> tag",
                            "method + action"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "The HTML part is what the user sees. The CGI script (PHP, Python, etc.) runs on the server and processes what the user submitted."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 2",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does METHOD=\"POST\" do differently from METHOD=\"GET\"?",
                        options: [
                            "POST is faster",
                            "POST appends data to the URL",
                            "POST sends data separately from the URL",
                            "POST only works with passwords"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "GET appends data to the URL (visible in address bar). POST sends it hidden in the request body — preferred for forms with sensitive or large data."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 3",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which input type shows bullets (●●●) instead of the characters typed?",
                        options: ["hidden", "text", "secure", "password"],
                        correctAnswerIndex: 3,
                        explanation: "type='password' masks the input visually. The data is still sent as plain text unless HTTPS is used."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 4",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What is the difference between radio buttons and checkboxes?",
                        options: [
                            "Radio allows multiple; checkbox only one",
                            "Checkbox allows multiple; radio allows only one",
                            "They are identical",
                            "Radio uses text; checkbox uses images"
                        ],
                        correctAnswerIndex: 1,
                        explanation: "Radio buttons in a group share the same name and allow only one selection. Checkboxes allow any number to be checked."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 5",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which tag creates a multi-line text input field?",
                        options: ["<input type='multiline'>", "<textbox>", "<textarea>", "<input type='paragraph'>"],
                        correctAnswerIndex: 2,
                        explanation: "<textarea rows='' cols=''> creates a resizable multi-line text box — perfect for comments and messages."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 6",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does the 'checked' attribute do on a radio button or checkbox?",
                        options: [
                            "Validates the input",
                            "Makes the field required",
                            "Pre-selects the option when the page loads",
                            "Locks the field so it cannot be changed"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Adding checked='checked' makes that option selected by default when the page loads."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 7",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "What does <input type='hidden'> do?",
                        options: [
                            "Makes the form invisible",
                            "Hides the submit button",
                            "Sends data to the server without showing it to the user",
                            "Encrypts the form data"
                        ],
                        correctAnswerIndex: 2,
                        explanation: "Hidden inputs pass extra information (like a user ID or page source) to the server without displaying anything to the user."
                    )
                ),
                LessonSection(
                    type: .quiz,
                    title: "Question 8",
                    content: "",
                    codeExample: nil,
                    challenge: nil,
                    quiz: Quiz(
                        question: "Which <select> attribute allows users to pick more than one option?",
                        options: ["size", "multi", "multiple", "selected"],
                        correctAnswerIndex: 2,
                        explanation: "Adding multiple='multiple' to <select> allows users to hold Ctrl/Cmd and click several options."
                    )
                ),
            ]
        ),


        
        
        
        
        // ═══════════════════════════════════════════
        // PHASE 2 – CSS STYLING (Beginner → Intermediate)
        // ═══════════════════════════════════════════
        
        
        
        
        // ═══════════════════════════════════════════
        // PHASE 2 (cont.) – FLEXBOX & NAV (Intermediate)
        // ═══════════════════════════════════════════
        
        
        
        // ═══════════════════════════════════════════
        // PHASE 3 – RESPONSIVE DESIGN (Intermediate)
        // ═══════════════════════════════════════════
        
        
        
        
        
        // ═══════════════════════════════════════════
        // PHASE 4 – JAVASCRIPT INTERACTIVITY (Advanced)
        // ═══════════════════════════════════════════
        
        
        
        
        
        // ═══════════════════════════════════════════
        // PHASE 5 – DEPLOYMENT & FINAL (Advanced, Theory Only)
        // ═══════════════════════════════════════════
        
        
        
    ]
}
